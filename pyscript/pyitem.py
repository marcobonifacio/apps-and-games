class PyItem(Element):
    
    def connect(self):
        self.md = main_div = document.createElement('div')
        main_div.id = "copy"
        main_div.value = ''
