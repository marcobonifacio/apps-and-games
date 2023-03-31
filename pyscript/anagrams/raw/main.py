import collections
import js

original = js.document.getElementById("original")
anagram = js.document.getElementById("anagram")
orig_out = js.document.getElementById("orig_out")
anag_out = js.document.getElementById("anag_out")

def check_anagram(str1, str2):
    d = (collections.Counter(''.join(sorted(str1.lower().strip()))) - 
    collections.Counter(''.join(sorted(str2.lower().strip()))))
    return ''.join(d.elements())

def do_check():
    orig_out.innerHTML = check_anagram(anagram.value, original.value)
    anag_out.innerHTML = check_anagram(original.value, anagram.value)
