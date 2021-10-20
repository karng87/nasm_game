import numpy as np
import matplotlib
matplotlib.rcParams['text.usetex'] = True
import matplotlib.pyplot as plt
N = 100
x = np.linspace(-1, 1, N)
y = np.linspace(-1, 1, N)
x,y = np.meshgrid(x,y)

r = np.sqrt(x**2 + y**2)
z = np.cos(r*np.pi*2)
gx, gy = np.gradient(z, 2/N)
fig = plt.figure()
ax = fig.add_subplot(projection='3d')
ax = fig.add_subplot()
#ax.plot_wireframe(x,y,z)
#ax.plot_surface(x,y,z)
ct = ax.contour(x,y,z, levles=100, cmap=matplotlib.cm.coolwarm)
plt.colorbar(ct)
ax.quiver(x,y,gx,gy,scale=200)
plt.show()
