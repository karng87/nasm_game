import sympy as sp
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt

fig = plt.figure()
ax = fig.add_subplot(projection='3d')

x,y,z = np.meshgrid(np.arange(-0.8, 1, 0.2),
                    np.arange(-0.8, 1, 0.2),
                    np.arange(-0.8, 1, 0.8))

u = x**2 
v = y**2 
w = z**2
ax.quiver(x,y,u,v, length=0.1)
plt.show()
