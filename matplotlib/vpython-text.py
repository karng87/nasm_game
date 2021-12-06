import vpython as vp
g1 = vp.graph(title="kinematics")
f1 = vp.gcurve()
x = 0
v = 0.2
a = .2
t = 0
dt = 0.5
while t < 2.5:
    v = v + a*dt
    x = x + v*dt
    t = t = dt
    f1.plot(t,x)
