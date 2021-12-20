import matplotlib.pyplot as plt
import numpy as np
fig = plt.figure()
ax = fig.add_subplot(projection='3d')
ax.set_xlim(xmin=-5, xmax=5)
ax.set_ylim(ymin=-0.1, ymax=10)
ax.set_zlim(zmin=-0.1, zmax=10)
ax.set_xlabel("X")
ax.set_ylabel("Y")
ax.set_zlabel("Z")

# plane
# \hat{n} = <a ,b, c>
# point p - <x0, y0, z0
# 0 = a(x-x0) + b(y-y0) +c(z-z0)
# p = < 0,0,0>
# \hat{n} = 0,0,1
# z = 0
x = np.linspace(-5,5,100)
y = np.linspace(0,10,100)
x,y = np.meshgrid(x,y)
z = np.zeros_like(y)
ax.plot_surface(x,y,z,alpha=0.5)

#### Q1(a,0,0) Q2(-a,0,0)
a = 2
Qp = np.array([a,0,0])
Qm = np.array([-a,0,0])
px = 1.5
py = 6
pz = 6

O = np.zeros(1)
ax.plot([a,-a],[0,0],[0,0],c='r',marker='o')
ax.plot([a,px],[0,py],[0,pz],c='r',marker='o')
ax.plot([-a,px],[0,py],[0,pz],c='r',marker='o')
ax.text(0,0,0,'O')
ax.text(a+1.0,-0.5,1,'+q(a,0,0)')
ax.text(-a-0.5,-0.5,1,'-q(-a,0,0)')
ax.text(px-0.5,py-0.5,pz+1,'P(x,y,z)')

## quiver \vec{p}
ax.quiver([0],[0],[0],[px],[py],[pz], arrow_length_ratio=0.05)
plt.show()
