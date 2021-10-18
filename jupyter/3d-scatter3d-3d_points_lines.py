import matplotlib.pyplot as plt
import numpy as np

ax = plt.axes(projection='3d')

# data for a three-dimentional line
z = np.linspace(0,15,1000)
x = np.sin(z)
y = np.cos(z)

ax.plot3D(x,y,z, 'gray')

zdata = 15 * np.random.random(100)
xdata = np.sin(zdata) + 0.1 * np.random.randn(100)
ydata = np.cos(zdata) + 0.1 * np.random.randn(100)

ax.scatter3D(xdata, ydata, zdata, c=zdata, cmap='Greens')
plt.show()
