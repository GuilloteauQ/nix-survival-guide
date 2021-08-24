from mother_driver import MotherDriver

class Driver(MotherDriver):
    def __init__(self):
        super().__init__(mother=False)
        self.name = "bar"

    def hello(self):
        print(f"Hello from {self.name}")
