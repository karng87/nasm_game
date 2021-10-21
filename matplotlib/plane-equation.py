import matplotlib.pyplot as plt
import matplotlib as mpl
mpl.rcParams['text.usetex'] = True
import numpy as np
"""
평면의 방정식
r'/displaystyle 
    \hat{n} = < a, b, c >
    point = < x_0, y_1, z_2 >
        a(x-x_0) + b(y-y_0) + c(z-z_0) = 0

    pioint p_0 = < x_0, y_0, z_0 >
    pioint p_1 = < x_1, y_1, z_1 >
    pioint p_2 = < x_2, y_2, z_2 >

        \vec{p_1} - \vec{p_0} \perp \vec{p_2} - \vec{p_0} 
"""

fig = plt.figure()
ax = fig.add_subplot(projection='3d')

x,y = np.meshgrid(range(10), range(10))
z = (9-x-y)/2

ax.plot_surface(x,y,z,alpha=0.5)
ax.scatter(x,y,z)
plt.show()
