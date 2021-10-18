import numpy as np
import matplotlib.pyplot as plt

########## scatter ###########
x = np.random.normal(size = 250)
y = np.random.normal(size = 250)
z = np.random.normal(size = 250)
ax = plt.axes(projection ="3d")

#ax.scatter(x,y,z, color="red")
#ax.view_init(0,0)
#plt.show()

######### plot3D ############# 
z = np.linspace(0,15,1000)
x = np.sin(z)
y = np.cos(z)

#ax = plt.axes(projection = "3d")

#ax.plot3D(x,y,z, color="yellow")
#plt.show()

######### contour3D ############# 
def c(x,y):
    return np.cos(np.sqrt(x**2 + y**2))

x = np.linspace(-5,5,25)
y = np.linspace(-5,5,25)
X,Y = np.meshgrid(x,y)

z = c(X,Y)
#ax.contour3D(x,y,z, 100)
#plt.show()

######### ax.plot_surface ############# 
ax.plot_surface(X,Y,z)
#plt.show()
######### ax.plot_wireframe ############# 
ax.plot_wireframe(X,Y,z)
plt.show()
