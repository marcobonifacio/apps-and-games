import collections
import justpy as jp


def check_anagram(str1, str2):
    d = collections.Counter(''.join(sorted(str1.lower().strip()))) - \
        collections.Counter(''.join(sorted(str2.lower().strip())))
    return ''.join(d.elements())


def do_check_a(self, mgs):
    self.div1.text = check_anagram(self.value, self.oth.value)
    self.div2.text = check_anagram(self.oth.value, self.value)
    self.oth.placeholder = 'Then, enter something here'


def do_check_b(self, mgs):
    self.div1.text = check_anagram(self.value, self.oth.value)
    self.div2.text = check_anagram(self.oth.value, self.value)
    

def page():
    wp = jp.QuasarPage(dark=True)
    title = jp.Div(
        text='Check anagrams',
        a=wp,
        classes='q-pa-xl text-h2 text-center text-primary'
        )
    label_row = jp.Div(
        a=wp,
        classes='q-px-xl q-py-sm q-gutter-xl row'
        )
    label_a = jp.Div(
        text='Original sentence',
        a=label_row,
        classes='col text-primary'
        )
    label_b = jp.Div(
        text='Check anagram',
        a=label_row,
        classes='col text-primary'
        )
    input_row = jp.Div(
        a=wp,
        classes='q-px-xl q-py-sm q-gutter-xl row'
        )
    input_a = jp.QInput(
        a=input_row,
        placeholder='Enter something here, first',
        input=do_check_a, 
        classes='col'
        )
    input_b = jp.QInput(
        a=input_row,
        input=do_check_b, 
        classes='col'
        )
    letters_row = jp.Div(
        a=wp,
        classes='q-px-xl q-py-lg q-gutter-xl row'
        )
    label_missing = jp.Div(
        text='Missing letters',
        a=letters_row,
        classes='col text-primary'
        )
    missing = jp.Div(
        text='',
        a=letters_row,
        classes='col-4'
        )
    label_exceeding = jp.Div(
        text='Exceeding letters',
        a=letters_row,
        classes='col text-primary'
        )
    exceeding = jp.Div(
        text='',
        a=letters_row,
        classes='col-4'
        )
    input_a.div1 = missing
    input_a.div2 = exceeding
    input_a.oth = input_b
    input_b.div1 = exceeding
    input_b.div2 = missing
    input_b.oth = input_a
    return wp


jp.justpy(page)