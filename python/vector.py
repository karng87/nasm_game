import sympy as sm
A = sm.Matrix([1,2,3])
B = sm.Matrix([5,4,1])

print(f'A.norm: {A.norm()}')
print(f'A.dot(B): {A.dot(B)}')
print(f'A.inv(): {A.dot(B)}')

