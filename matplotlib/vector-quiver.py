import numpy as np
import matplotlib
matplotlib.rcParams['text.usetex'] = True
import matplotlib.pyplot as plt

fig = plt.figure()

#### BASIC ####
"""
x = 0
y = 0
z = 0
u = 0
v = 2
w = 5
"""
x = [0,0,0] # start x1 x2 x3
y = [0,0,0] # start y1 y2 y3
z = [0,0,0] # start z1 z2 z3

###### <0,2,3> <3,1,-2> <3,-2,1> ######
u = [0,3,3]     # end x1' x2' x3'
v = [2,1,3]     # end y1', y2', y3'
w = [3,-2,1]    # end z1' z2' z3'

ax = fig.add_subplot(projection = '3d')
#ax.quiver(x,y,z,u,v,w)
ax.quiver([0,0,0],[0,0,0],z,[0,3,3],v,w)
ax.plot([0],[2],[3], 'ro')
ax.plot([3],[1],[-2], 'bo')
ax.plot([3],[3],[1], 'go')

ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

ax.set_xlim(xmin=-10, xmax=10)
ax.set_ylim(ymin=-10, ymax=10)
ax.set_zlim(zmin=-10, zmax=10)

plt.show()

"""
############
ax = fig.add_subplot(projection='3d')
u = [1,2,3]
v = [4,9,2]
o = [0,0,0]


#ax.quiver(o[0],o[1],o[2],u[0],u[1],u[2],v[0],v[1],v[2],u[0] + v[0], u[1] + v[1], u[2] + v[2])
ax.set_xlim([-1,10])
ax.set_ylim([-10,10])
ax.set_zlim([0,10])

ax.quiver(o[0],o[1],o[2],u[0],u[1],u[2])
ax.quiver(o[0],o[1],o[2],v[0],v[1],v[2])
ax.quiver(o[0],o[1],o[2],u[0] + v[0], u[1] + v[1], u[2] + v[2])
"""
"""
##### 3D ######
ax = fig.add_subplot(projection='3d')
N = 5 
x = np.linspace(-1,1,N)    # vector in x
y = np.linspace(-1,1,N)    # vector in y
z = np.linspace(-1,1,N)    # vector in y

x,y,z = np.meshgrid(x,y,z)      # 2 sepatrate 2D matries

u = x  # \hat{x} direction
v = y  # \hat{y} direction
w = z

ax.quiver(x,y,z,u,v,w, length=0.2)
plt.show()
"""

