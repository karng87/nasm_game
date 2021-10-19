import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np

x = np.arange(-5,5,0.25)
y = np.arange(-5,5,0.25)
x,y = np.meshgrid(x,y)
r = np.sqrt(x**2 + y**2)
z = np.sin(r)

fig = plt.figure()

ax = fig.add_subplot(221,projection='3d')
surf = ax.plot_surface(x,y,z, cmap=mpl.cm.coolwarm )
fig.colorbar(surf, shrink=0.5, aspect = 10)

ax = fig.add_subplot(222,projection='3d')
wiref = ax.plot_wireframe(x,y,z)

ax = fig.add_subplot(223,projection='3d')
theta = np.linspace(-4 * np.pi, 4 * np.pi, 100)
z = np.linspace(-2,2,100)
r = z**2 + 1
x = r * np.sin(theta)
y = r * np.cos(theta)

linef = ax.plot(x,y,z)


ax = fig.add_subplot(224,projection='3d')
levelc = ax.contour(x,y,z)

plt.show()
