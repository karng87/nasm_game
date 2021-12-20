import matplotlib
matplotlib.rcParams['text.usetex']  = True
import matplotlib.pyplot as plt
import numpy as np
import sympy as sp
"""
    # ax.quiver([sx],[sy],[sz],[ex],[ey],[ez])
        sx[] = starting compoent of x cordinate
        sy[] = starting compoent of y cordinate
        sz[] = starting compoent of z cordinate
            sx0 = starting point of x[0]
            sy0 = starting point of y[0]
            sz0 = starting point of z[0]
        ex[] = end compoent of x cordinate
        ey[] = end compoent of y cordinate
        ez[] = end compoent of z cordinate
            ex0 = ending point of x[0]
            ey0 = ending point of y[0]
            ez0 = ending point of z[0]
"""
fig = plt.figure()
ax = fig.add_subplot(projection='3d')
########
"""
x_hat = np.array([1,0,0])
y_hat = np.array([0,1,0])
z_hat = np.array([0,0,1])

v_hat = np.eye(3)
v_0 = np.zeros((3,3))

#ax.quiver([0,0,0],[0,0,0],[0,0,0],[1,2,3],[4,5,6],[3,3,3])
ax.quiver(v_0[0],v_0[1],v_0[2],v_hat[0],v_hat[1],v_hat[2])
"""
########
x = np.arange(0,2*np.pi,.2)
x,y = np.meshgrid(x,x)
z = np.zeros_like(x)

pix = np.array([0,(1/2)*np.pi,np.pi,(3/2)*np.pi,2*np.pi])
sx,sy = np.meshgrid(pix,pix)
#sx = sx.flatten()
#sy = sy.flatten()

sz = np.zeros_like(sx)
su = np.cos(sx)
sv = np.sin(sy)
sw = np.sqrt(su**2 + sv**2)

u = np.cos(x)
v = np.sin(y)
ax.quiver([0],[0],[0],[np.cos(0)],[np.sin(0)],[0])
ax.quiver(sx,sy,sz,su,sv,sw)
#ax.quiver(x[::3,::3],y[::3,::3],z[::3,::3],u[::3,::3],v[::3,::3],z[::3,::3],pivot='middle')
ax.scatter(sx,sy,sz,color='r',s=5)
#ax.plot(sx,sy,sz,'ro')

"""
ax.plot([0],[0],[0],'ro')
ax.plot([np.pi/2],[0],[0],'ro')
ax.plot([np.pi/2],[np.pi/2],[0],'ro')
ax.plot([np.pi/2],[np.pi],[0],'ro')
ax.plot([np.pi],[0],[0],'ro')
ax.plot([np.pi],[np.pi/2],[0],'ro')
ax.plot([np.pi],[np.pi],[0],'ro')
ax.plot([np.pi],[np.pi],[0],'ro')
ax.plot([0],[np.pi/2],[0],'ro')
ax.plot([0],[np.pi],[0],'ro')
ax.plot([0],[np.pi/2],[0],'ro')
#ax.plot([0,1],[0,0],[0,1],'ro')
"""
ax.set_xlim(xmin=-1, xmax=7)
ax.set_ylim(ymin=-1, ymax=7)
ax.set_zlim(zmin=-1, zmax=7)

ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

plt.show()
