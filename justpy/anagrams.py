import collections
import justpy as jp

title_classes = 'my-2 text-lg font-bold text-gray-700'
label_classes = 'my-2 font-semibold text-blue-700'
input_classes = 'bg-gray-200 border-2 border-gray-200 rounded w-64 py-2 px-4 \
    focus:outline-none focus:bg-white focus:border-blue-700'
text_classes = 'my-2'


def check_anagram(str1, str2):
    d = collections.Counter(''.join(sorted(str1.lower().strip()))) - \
        collections.Counter(''.join(sorted(str2.lower().strip())))
    return ''.join(d.elements())


def do_check(self, mgs):
    self.div1.text = check_anagram(self.value, self.oth.value)
    self.div2.text = check_anagram(self.oth.value, self.value)


def show_form():
    wp = jp.WebPage()
    d_outer = jp.Div(
        a=wp, 
        classes='m-2 p-4'
        )
    d_title = jp.Div(
        text='Controlla anagrammi', 
        a=d_outer, 
        classes=title_classes
        )
    d_lab_orig = jp.Div(
        text='Frase da anagrammare', 
        a=d_outer, 
        classes=label_classes
        )
    in_orig = jp.Textarea(
        a=d_outer, 
        rows=3, 
        input=do_check, 
        classes=input_classes
        )
    d_lab_anag = jp.Div(
        text='Frase anagrammata', 
        a=d_outer, 
        classes=label_classes
        )
    in_anag = jp.Textarea(
        a=d_outer, 
        rows=3, 
        input=do_check, 
        classes=input_classes
        )
    d_lab_miss = jp.Div(
        text='Lettere mancanti', 
        a=d_outer, 
        classes=label_classes
        )
    d_miss = jp.Div(
        text='', 
        a=d_outer, 
        classes=text_classes
        )
    d_lab_exc = jp.Div(
        text='Lettere eccedenti', 
        a=d_outer, 
        classes=label_classes
        )
    d_exc = jp.Div(
        text='', 
        a=d_outer, 
        classes=text_classes
        )
    in_orig.div1 = d_miss
    in_orig.div2 = d_exc
    in_orig.oth = in_anag
    in_anag.div1 = d_exc
    in_anag.div2 = d_miss
    in_anag.oth = in_orig
    return wp


jp.justpy(show_form)