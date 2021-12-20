import numpy as np
import sympy as sp

x, y, z, k, l = sp.symbols('x y z k l')

##### standard linear approcimation ####
y = (1 + x)**k
b = y.subs({x:0})
z = sp.diff(y,x).doit().subs({x:0}) * x + b
#print (z)

### if f'(0) = 0 then a = f''(0)
y = (1-x**2)**(-1/2)
dy = sp.diff(y,x)
dy = dy.subs({x:0})
print(sp.diff(y,x).doit().subs({x:0}))

ddy = sp.diff(y,x,x)
ddy = ddy.subs({x:0})
print(sp.diff(y,x,x).doit().subs({x:0}))
