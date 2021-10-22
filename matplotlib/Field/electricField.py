import matplotlib.pyplot as plt
import numpy as np
fig = plt.figure()
ax = fig.add_subplot(projection='3d')
ax.set_xlim(xmin=-.1, xmax=10)
ax.set_ylim(ymin=-.1, ymax=10)
ax.set_zlim(zmin=-.1, zmax=10)
ax.set_xlabel("X")
ax.set_ylabel("Y")
ax.set_zlabel("Z")

# Q1(0,1,3) Q2(2,0,2)
Qx = np.array([2,0,0])
Qy = np.array([0,2,0])
Qz = np.array([0,0,2])
O = np.zeros_like(Qx)
ax.plot([0],[0],[0],'ro')
ax.text(0.1,0.1,0.1,'O')
ax.quiver(O,O,O,Qx,Qy,Qz)

ax.text(Qx[0],Qy[0],Qz[0],'$Q_{1}$')
ax.text(Qx[1],Qy[1],Qz[1],'$Q_{2}$')
ax.text(Qx[2],Qy[2],Qz[2],'$Q_{i}$')

ax.plot(np.hstack([Qx,[Qx[0]]]),np.hstack([Qy,[Qy[0]]]),np.hstack([Qz,[Qz[0]]]),'r:')
ax.plot(np.hstack([Qx,[Qx[0]]]),np.hstack([Qy,[Qy[0]]]),np.hstack([Qz,[Qz[0]]]),'r:')

## q
q = np.array([6])
qx = np.hstack([[Qx[0]],q])
qy = np.hstack([[Qy[0]],q])
qz = np.hstack([[Qz[0]],q])
ax.plot(np.hstack([[Qx[0]],q]),np.hstack([[Qy[0]],q]),np.hstack([[Qz[0]],q]),'r:')
ax.plot(np.hstack([[Qx[1]],q]),np.hstack([[Qy[1]],q]),np.hstack([[Qz[1]],q]),'r:')
ax.plot(np.hstack([[Qx[2]],q]),np.hstack([[Qy[2]],q]),np.hstack([[Qz[2]],q]),'r:')
ax.text(q[0],q[0],q[0],'q')


plt.show()
