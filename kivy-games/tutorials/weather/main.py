from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import ObjectProperty
from kivy.network.urlrequest import UrlRequest
import json
import os


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


class WeatherApp(App):
    pass


if __name__ == '__main__':
    WeatherApp().run()
