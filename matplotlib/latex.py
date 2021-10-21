import matplotlib
matplotlib.rcParams['text.usetex'] = True
import matplotlib.pyplot as plt

fig = plt.figure()
ax = fig.add_subplot(projection = '3d')

ax.text(0.10, 0.80, r"$\displaystyle \vec F_e = \frac{1}{4\pi\epsilon_0} \int_v \frac{q q_{1}}{\left | \vec r - \vec r_1 \right |^2} \frac{\vec r - \vec r_1}{\left | \vec r - \vec r_1 \right |}$")

plt.show()
