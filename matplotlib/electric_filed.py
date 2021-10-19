import numpy as np
import scipy as sp
from scipy.integrate import quad
import matplotlib
matplotlib.rcParams['text.usetex'] = True
import matplotlib.pyplot as plt
import sympy as sp
import plotly.graph_objects as go
#from Ipython.display import HTML

fig = plt.figure()
ax = fig.add_subplot()
ax.text(0.05, 0.95, r"gravity: $\displaystyle \vec F_g = G \frac{M m}{r^2}$")
ax.text(0.10, 0.90, r"gravity filed: $\displaystyle \vec E_g = G \frac{M}{r^2}$")
ax.text(0.05, 0.85, r"point charege: $\displaystyle \vec F_e = \frac{1}{4\pi\epsilon_0} \frac{q q_{1}}{r^2}$")
ax.text(0.10, 0.80, r"$\displaystyle \vec F_e = \frac{1}{4\pi\epsilon_0} \int_v \frac{q q_{1}}{|\vec r - \vec r_1|^2} \frac{\vec r - \vec r_1}{|\vec r - \vec r_1|}$")
ax.text(0.10, 0.75, r"potential energy: $\displaystyle \vec E = \frac{F}{q}$")
ax.text(0.10, 0.70, r"charge filed: $\displaystyle \vec E = \frac{1}{4\pi\epsilon_0} \int_v \frac{\vec r - \vec r_1}{|\vec r - \vec r_1|^3} dq$")
#plt.show()

##### standard linear approcimation ####
x, y, z, k, l = sp.symbols('x y z k l')
#y = (1 + x)**k
#b = y.subs({x:0})
#z = sp.diff(y,x).doit().subs({x:0}) * x + b
#print (z)

### if f'(0) = 0 then a = f''(0)
y = (1-x**2)**(-1/2)
dy = sp.diff(y,x)
dy = dy.subs({x:0})
print(sp.diff(y,x).doit().subs({x:0}))

ddy = sp.diff(y,x,x)
ddy = ddy.subs({x:0})
print(sp.diff(y,x,x).doit().subs({x:0}))
