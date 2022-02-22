from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.recycleview.views import RecycleDataViewBehavior
from kivy.uix.label import Label
from kivy.properties import BooleanProperty, ObjectProperty
from kivy.uix.recycleboxlayout import RecycleBoxLayout
from kivy.uix.behaviors import FocusBehavior
from kivy.uix.recycleview.layout import LayoutSelectionBehavior
from kivy.network.urlrequest import UrlRequest

import json
import os


class SelectableRecycleBoxLayout(FocusBehavior, LayoutSelectionBehavior,
                                 RecycleBoxLayout):
    pass


class SelectableLabel(RecycleDataViewBehavior, Label):
    index = None
    selected = BooleanProperty(False)
    selectable = BooleanProperty(True)

    def refresh_view_attrs(self, rv, index, data):
        self.index = index
        return super(SelectableLabel, self).refresh_view_attrs(
            rv, index, data)

    def on_touch_down(self, touch):
        if super(SelectableLabel, self).on_touch_down(touch):
            return True
        if self.collide_point(*touch.pos) and self.selectable:
            return self.parent.select_with_touch(self.index, touch)

    def apply_selection(self, rv, index, is_selected):
        self.selected = is_selected


class AddLocationForm(BoxLayout):
    search_input = ObjectProperty()
    search_results = ObjectProperty()
    
    def search_location(self):
        search_template = 'http://api.openweathermap.org/data/2.5/' + \
            'find?q={}&type=like&appid={}'
        key = os.environ.get('OpenWeatherKey')
        search_url = search_template.format(self.search_input.text, key)
        request = UrlRequest(search_url, self.found_location)

    def found_location(self, request, data):
        data = json.loads(data.decode()) if not isinstance(data, dict) \
            else data
        cities = [{'text': '{} ({}) - lat.:{} lon.:{}'.format(
            d['name'], 
            d['sys']['country'],
            d['coord']['lat'],
            d['coord']['lon'])} for d in data['list']]
        self.search_results.data = cities


class WeatherRoot(BoxLayout):
    pass


class WeatherApp(App):
    pass


if __name__ == '__main__':
    WeatherApp().run()
