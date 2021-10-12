class Engine:
    def __init__(self, name):
        self.name = name
        self.is_parent = True

    def run(self):
        self.whoami()
        self.parent()

    def whoami(self):
        print(self.name)

    def parent(self):
        if self.is_parent:
            print("Parent")
        else:
            print("Child")
