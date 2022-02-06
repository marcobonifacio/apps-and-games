from kivy.app import App
from kivy.uix.label import Label


class YourApp(App):
    def build(self):
        root_widget = Label(text='Hello World!')
        return root_widget
    

if __name__ == '__main__':
    YourApp().run()