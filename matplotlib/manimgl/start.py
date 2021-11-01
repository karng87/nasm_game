from manimlib import *
class MyCircle(Scene):
    def construct(self):
        c = Circle()
        c.set_fill(BLUE, opacity=0.5)
        c.set_stroke(BLUE_E, width=4)
        
        #self.add(c)
        s = Square()
        self.play(ShowCreation(s))
        self.wait()
        self.embed()

        self.play(ReplacementTransform(s,c))
        self.wait()
        self.play(c.animate.stretch(4,0))
        self.play(Rotate(c,90*DEGREES))
        self.play(c.animate.shift(2*RIGHT).scale(0.25))
        
        t = Text("""
            In general, using the interactive shell
            is very helpful when developing new scenes
        """)
        self.play(Write(t))

        always(c.move_to, self.mouse_point)
