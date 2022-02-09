.code16
.global _start
_start:
  cli

  // Set SS and Sp as they may get used by BIOS calls.
  xor %ax, %ax
  mov %ax, %ss
  mov $0x0000, %sp

  // Get input to %al
  mov $0x00, %ah
  int $0x16

  // Print the input from %al
  mov $0x0e, %ah
  int $0x10

  hlt

  .org 510
  .word 0xaa55
/*
int 16 / ah == 00
  get keystroke from keyboard(no echo)
  return:
    ah = bios scan code
    al = ASCII charactor
    if a keystroke is present, it is removed from the keyboard buffer
int 16 / ah = 01
  check for keystroke in the keyboard buffer
  return:
    zf = 1 - if keystroke is not available
    zf = 0 - if keystroke available
    ah = bios scan code
    al = ASCII charactor
    if a keystroke is present, it is not removed from the keyboard buffer.
*/

/*
# Interrupt
> software interrupt
> hardware interrupt

## IRQs := interrupt requests
  When a component in the computer 
    wishes to issue a hardware interrupt, 
      which involves putting a signal on an interrupt request line. 
    This sends an interrupt request (IRQ) to the CPU.

     Just like software interrupts, IRQs have numbers. 
     The keyboard controller uses IRQ 1. 
     The x86 interrupt controller maps this to interrupt 9, 
     so receiving an IRQ from the keyboard controller has 
      the same effect as executing int 9.

## Interrupt Handlers
  When an interrupt is triggered (either through an interrupt call or an IRQ), 
  the CPU stops doing whatever it is doing and 
    invokes the interrupt handler. 
  This is just like making a function call, 
    except that the flags are also pushed on the stack, and 
    the return is done using iret rather than ret.
  The addresses of the interrupt handlers are stored 
    at the beginning of RAM. 
  For each interrupt (there are 256 of them), 
    a segment and an offset are stored. 
  To invoke an interrupt handler, 
    the system multiplies the interrupt number by 4 and 
      jumps to the address stored at that location 
      (after saving the flags and the return address).

### The Keyboard IRQ
  The keyboard controller generates an IRQ 1 
    each time a key is pressed or released. 
  To catch these IRQs, 
    we need to override the interrupt handler for interrupt 9. 
  This is accomplished by overwriting the address 
    for that handler with the address of our own service routine.

  push word 0
  pop ds
  cli // clear the IF flag in the EFLAGS register and no other flags are affected.
  mov [4*1], word keyboardHandler
  mov [4*1 + 2], cs
  sti // sets the interrupt flag(IF) in the EFLAGS register

Note that, 
  while we are messing with the interrupt vector, 
    we disable interrupts. 
    This prevents the keyboard driver from getting called 
      while it points to a nonsense address. 
  The routine for handling the keyboard interrupt looks as follows:

  keyboardHandler:
  ; save our register!
  pusha

  ; Read code
  in al, 60h

  ;Ignore codes with high bit set
  test al, 80h
  jnz .end

  ; Read the ASCII code from the table
  mov bl, al
  xor bh, bh
  mov al, [cs:bx + keymap]

*/
