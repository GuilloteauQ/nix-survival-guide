from engine import Engine

class MyEngine(Engine):
    def __init__(self, name):
        super(MyEngine, self).__init__(name)
        self.is_parent = False
