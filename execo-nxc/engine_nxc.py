from engine import Engine

class NXCEngine(Engine):
    """
    Engine class for NXC
    """

    def __init__(self):
        super(NXCEngine, self).__init__()
        self.type = "son"

    def run(self):
        print("NXC")
