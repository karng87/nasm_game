;------------------------------------------------
; ./a.out &
;   cat /proc/pid/maps
;
;      address           perms  offset    dev   inode   pathname
;       00400000-00401000 r--p   00000000  08:02 4064017 /home/jkarng/Proje..
;       r = read
;       w = write
;       x = execute
;       s = shared
;       p = private (copy on write)
;------------------------------------------------- 

section .data
  correct: dq -1

section .text
  global main
  main:
        jmp main

;-------------------------------------------
; Process and Thread
; https://goodgid.github.io/What-is-Thread/
;-------------------------------------------
