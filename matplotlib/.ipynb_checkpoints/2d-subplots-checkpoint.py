import matplotlib.pyplot as plt
import numpy as np
import sympy as sp

#fig, ax = plt.subplots(2,1)
#fig = plt.figure(figsize=plt.figaspect(0.5))
fig = plt.figure()
fig.suptitle(r"$\int_{0}^{oo} f(x)dx$")

ax = fig.add_subplot(2,1,1)
ax.plot([4,5,6],[4,5,6],'ys')
ax.set_title(r"$\nabla \cdot \vec a$")

ax = fig.add_subplot(2,1,2)
ax.plot([1,2,3],[4,5,6])
ax.grid(True)

fig = plt.figure()
fig.suptitle(r"$\iint_{0}^{oo} f(x)dx$")
ax = fig.add_subplot()
ax.plot([1,2,3],[4,5,6])
ax.grid(True)
plt.show()
