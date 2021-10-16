# 3d plot

    from matplotlib import pyplot as plt
    from matplotlib import cm # color map
    
    import numpy as np


    f = lambda x, y: np.sin(x) * np.cos(y)
    x = np.linspace(-3,3,100)
    y = np.linspace(-3,3,100)
    X, Y = np.meshgrid(x,y)
    F = f(X,Y)

    def func(A, E):
        ax = plt.axes(projection = '3d')
        ax.plot_surface(X,Y,F, cmap=cm.coolwarm)
        ax.view_init(elev=E, azim=A)
        
        plt.rcParams['figure.figsize'] = (8,6)
        plt.show()

    #f_interactive(45,45)

    from ipywidgets import interactive
    iplot = interactive(func,E=(-90,90,5), A=(-90,90,5))
    iplot