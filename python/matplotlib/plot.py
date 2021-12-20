import numpy as np
import matplotlib.pyplot as plt

fig = plt.figure()
ax = fig.add_subplot(projection='3d')
ax.plot([1,2,3],[4,5,6],[1,2,3],'ro')
ax.set_xlabel('x')
plt.show()


