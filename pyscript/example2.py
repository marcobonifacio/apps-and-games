# https://www.jhanley.com/pyscript-loading-python-code-in-the-browser/

import js
from js import document
 
def main():
  msg = document.getElementById("msg")
  msg.innerHTML = 'Hello world'
 
main()