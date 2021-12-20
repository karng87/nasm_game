# manim intall
> ### sudo pacman -S pango pkg-config
> ### pip install manimgl
> ### manimgl
>> #### termnal window with black screen

# make project fold
> ### mkdir project folder, cd project folder
> ### vi start.py
```python
    from manimlib import *
    class MyObject(Scene):
        def construct(self):
            c = Circle()
            c.set_fill(BLUE, opacity=0.5)
            c.set_stroke(BLUE_E, width=4)

            self.add(c)
```
# manimgl start.py MyObject
> ### always(fun, Mobj, UP), 
>> ### always_redraw(Mobj:), 
>> ### f_always(fun, arg_value) : function always excute per frame ( 

> ### Scenes
>> #### Scene.clear(self)
>>> #### A Scene is the canvas of your animation.
>>> #### Scene.clear(self)
>>> #### Scene.play(self)

> ### self.play
>> #### play(ShowCreation(mobj))
> ### Mobjects
>> #### Circle, Squre, Text, Tex, Brace,
> ### Animations
