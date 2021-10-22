import matplotlib.pyplot as plt
import numpy as np

fig = plt.figure()
ax = fig.add_subplot(projection='3d')

#x = np.linspace(-2,2,10)
x = np.linspace(-3,3,10)
y = np.linspace(-3,3,10)
z = np.linspace(-3,3,10)
x,y,z = np.meshgrid(x,y,z)
r = np.array([0,0,0])
r = np.zeros(3)
q = 1

def E(q,r,x,y,z):
    return q*(x-r[0])/(((x-r[0])**2 + (y-r[1])**2 + (z-r[2])**2)**(1.5)),\
           q*(y-r[1])/(((x-r[0])**2 + (y-r[1])**2 + (z-r[2])**2)**(1.5)),\
           q*(z-r[2])/(((x-r[0])**2 + (y-r[1])**2 + (z-r[2])**2)**(1.5)),\


vx,vy,vz = E(q,r,x,y,z)
ax.quiver(x,y,z,vx,vy,vz)
plt.show()
