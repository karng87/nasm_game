import numpy as np
import matplotlib 
matplotlib.rcParams['text.usetex'] = True
import matplotlib.pyplot as plt

#x,y = np.meshgrid(np.linspace(0,4*np.pi, 1000),np.linspace(0,4*np.pi, 1000))
t = np.linspace(0,4*np.pi, 100)
a = 1
omega = 1
z = a*np.sin(omega*t)
y = z
fig = plt.figure()
ax = fig.add_subplot(projection='3d')
ax.plot(t,y,z)
ax.scatter(t,y,z)
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z')
ax.grid(True, axis='t')
plt.show()

