from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.slider import Slider

from kivy.uix.boxlayout import BoxLayout
from kivy.uix.label import Label
from kivy.uix.slider import Slider

from kivy.uix.widget import Widget
from kivy.graphics import Rectangle, Color, Line

from random import random

class DrawingWidget(Widget):
    def __init__(self, **kwargs):
        super(DrawingWidget, self).__init__(**kwargs)

        with self.canvas:
            Color(1, 1, 1, 1)
            self.rect = Rectangle(size=self.size,
                                  pos=self.pos)
        self.bind(pos=self.update_rectangle,
                  size=self.update_rectangle)

    def update_rectangle(self, instance, value):
        self.rect.pos = self.pos
        self.rect.size = self.size

    def on_touch_down(self, touch):
        super(DrawingWidget, self).on_touch_down(touch)

        if not self.collide_point(*touch.pos):
            return

        with self.canvas:
            Color(random(), random(), random())
            self.line = Line(points=[touch.pos[0], touch.pos[1]], width=2)

    def on_touch_move(self, touch):
        if not self.collide_point(*touch.pos):
            return

        self.line.points = self.line.points + [touch.pos[0], touch.pos[1]]


class Interface(BoxLayout):
    pass

class DrawingApp(App):

    def build(self):
        root_widget = Interface()
        return root_widget

DrawingApp().run()