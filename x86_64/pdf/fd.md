# fd [[file descriptor]](https://catonmat.net/bash-one-liners-explained-part-three)
    /dev/fd
[[fd table]](./img/fd-table.png)

## fd = 0 
    /dev/fd/0
    stdin

## fd = 1
    /dev/fd/1
    stdout

## fd = 2
    /dev/fd/2
    stderr

## > == 1> destination
    stdout == /dev/fd/1 redirct 
## 2> destination
    stderr == /dev/fd/2 reidrect
## &> == >&
    & == /dev/fd/1 and /dev/fd/2
    stdout & stderr >

## command >&my_file == command &>my_file

## command > /dev/null
    discard output of a command
