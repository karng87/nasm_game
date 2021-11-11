"""
https://www.youtube.com/watch?v=yyqOvA8dlvk&list=PL4ElPQw0dPdlhkDrkVLsktCZWkILzKhvM&index=1

Evalute the lin integral of the vector field \vec{u} = (xy,z^2,z) along the curve given by x=1+t, y = 0, z=t^2, 0 \leq t \leq 3
"""
import sympy as sm
import sympy.vector

C = sm.vector.CoordSys3D('')
t = sm.symbols('t')
F , r, x, y, z = sm.symbols('F r x y z',cls=sm.Function)

x=x(t)
y=y(t)
z=z(t)

F = sm.Matrix([x*y,z**2,x])
r = sm.Matrix([x,y,z])

sol = sm.integrate(F.dot(sm.diff(r,t)).subs([(x,1+t),(y,0),(z,t**2)]).doit(),(t,0,3))
print(f'F.dr = {sol}')

"""
u = (y, -x, 0)
segment 
(a) y = 1 0\leq x \leq 1 
(b) x=1, l\leq y \leq 2
"""
F = sm.Matrix([y,-x,0])

r = sm.Matrix([x,y,z])
r1 = sm.Matrix([t,1,0])
r2 = sm.Matrix([1,t+1,0])

sol = sm.integrate(F.dot(r.diff(t)).subs([(x,t),(y,1),(z,0)]).doit().simplify(),(t,0,1))
print(f'F.dr_1 = {sol}')

#sol = sm.integrate(F.dot(r.diff(t)).subs([(x,1),(y,t+1),(z,0)]).doit().simplify(),(t,0,1))
#sol = sm.integrate(F.subs([(x,1),(y,t+1),(z,0)]).dot(r2.diff(t)).doit().simplify(),(t,0,1))
sol = sm.integrate(F.dot(r2.diff(t)).subs([(x,1),(y,t+1),(z,0)]).doit().simplify(),(t,0,1))

print(f'F.dr_2 = {sol}')

