import numpy as np
import sympy as sp
from sympy.abc import s,t,x,y,z
from sympy.integrals import inverse_laplace_transform
import matplotlib.pyplot as plt

U1 = 2/s*sp.exp(-s)
