# prefix notation

# '
> do not evaluate

# command
# predict function
> ## atom
```
(setq x 10)
(atom x)
>> t
```
> ## listp
> ## equal
```
(equal 'a (car '(a b)))
>> t
```
> ## evenp
> ## oddp
> ## numberp
> ## zerop
> ## null
> ## not
> ## and
> ## or

#
> ## list
```
(list 'a '(bc))
>> (a b c)
```
> ## car
>> content address

> ## cdr
>> content data

> ## cons
>> atom + list
```
(cons 'a '(b c))
>> (a b c)
```

> ## append
>> list + list
```
(append 'a '(b c))
>> (a b c)

```

> ## last
```
(last '(abc))
>> c
```

> ## member
```
(member 'b '(a b c))
>> (b c)
```
> ## reverse
```
(reverse '(a '(b c) d))
>> (d (b c) a)
```
> ## setq
```
(setq x 10)
>> x = 10
```

# type
> ## type of atom
>> numbers characters
> ## type of string
>> "my string"
> ## type of list
>> '(a b c)'

# io
> ## print
> ## princ
