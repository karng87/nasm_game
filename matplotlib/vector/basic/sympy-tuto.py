import numpy as np
import sympy as sp

x, y ,z = sp.symbols('x y z')
dx = sp.diff(sp.cos(x), x)
print(dx.subs(x,np.pi))
dx = sp.exp(x*y*z)
print(sp.diff(dx,x,y,z))
print(sp.diff(dx,y))
print(sp.diff(dx,z))
dx1 = sp.Derivative(dx,x,y,z)
dx1

