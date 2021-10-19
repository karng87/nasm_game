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
ax.text(0.10, 0.80, r"$\displaystyle \vec F_e = \frac{1}{4\pi\epsilon_0} \int_v \frac{q q_{1}}{\left | \vec r - \vec r_1 \right |^2} \frac{\vec r - \vec r_1}{\left | \vec r - \vec r_1 \right |}$")
ax.text(0.10, 0.75, r"potential energy: $\displaystyle \vec E = \frac{F}{q}$")
ax.text(0.10, 0.70, r"charge filed: $\displaystyle \vec E = \frac{1}{4\pi\epsilon_0} \int_v \frac{\vec r - \vec r_1}{\left | \vec r - \vec r_1 \right |^3} dq$")

#plt.show()

t = sp.symbols('t', positive=True)
x,y,z = sp.symbols('x y z')
r = sp.Matrix([x,y,z])
r_p = sp.Matrix([sp.cos(4*t), sp.sin(4*t),t])
sep = r - r_p
print (sep)

