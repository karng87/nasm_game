depth :0 v{} src{A, B, C} dest {[]}

```c
f(0, src, dest) {f(1,src,dest){}.........................<v:src[0]>........................................f(1,src,dest){}}end 
                           /                                                                                          \                        
  f(2,srd,dest){}.........<v:src[1]>................f(2,src,dest){}end                                    f(2,srd,dest){}.....v:src[1].......f(2,src,dest){}end
               /                                                 \                                                     /                                  \
     f(3,srd,dest){}..<v:src[2]>..f(3,src,dest){}end   {f(3,srd,dest){}...<v:src[2]>...f(3,src,dest{}end      f(3,srd,dest){}.v:src[2].f(3,src,dest){}end  {f(3,srd,dest){}.v:src[2].f(3,src,dest{}end {dest=v}end
                  /                             \                    /                             \                       /                             \                    /                             \
      if{dest=v}end                   if{dest=v}end       if{dest=v}end                      if{dest=v}end        if{dest=v}end                   if{dest=v}end       if{dest=v}end                      if{dest=v}end
    depth=0 v={} src={A,B,C}  dest={{}{}{}{}{}{}{}{}}
f(0,src,dest){f(1,src,dest){}end.........................<v:src[0]>................f(1,src,dest){}}end  depth[0] src[3]{A,B,C} dest[6]{}
                           /                                                                     \                        
  f(2,srd,dest){}.........<v:src[1]>................f(2,src,dest){}end                 f(2,srd,dest){}........v:src[1].......f(2,src,dest){}end
               /                                                 \                                  /                                      \
  f(3,srd,dest){}<v:src[2]>f(3,src,dest){}end  {f(3,srd,dest){}<v:src[2]>f(3,src,dest{}end  f(3,srd,dest){}.v:src[2].f(1,src,dest){}end  {f(1,srd,dest){}.v:src[2].f(1,src,dest{}end
               /                        \                   /                        \                  /                         \                   /                        \
      if{dest=v}end             if{dest=v}end       if{dest=v}end             if{dest=v}end    if{dest=v}end              if{dest=v}end       if{dest=v}end            if{dest=v}end
```
