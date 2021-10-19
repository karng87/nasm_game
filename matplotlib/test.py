import matplotlib.pyplot as plt
import numpy as np
import sympy as sp

fig, ax = plt.subplots(2,1)
fig.suptitle(r"$\int_{0}^{oo} f(x)dx$")
ax[0].plot([4,5,6],[4,5,6],'ys')
ax[0].set_title(r"$\nabla \cdot \vec a$")

ax[1].plot([1,2,3],[4,5,6])
ax[1].grid(True)


plt.show()
