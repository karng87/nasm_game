from manim import *
class Mobj(Scene):
    def construct(self):
        c = Circle()
        self.play(Create(c))
