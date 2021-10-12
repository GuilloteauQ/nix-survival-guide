from engine import Engine

import importlib.util
import inspect
import sys

def main():
    args = sys.argv
    file_location = args[1]


    spec = importlib.util.spec_from_file_location("my_module", file_location)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    clsmembers = inspect.getmembers(module, inspect.isclass)
    clsmembers = [(name, cls) for (name, cls) in clsmembers if issubclass(cls, Engine) and cls != Engine]
    if len(clsmembers) == 0:
        print("no class found")
    if len(clsmembers) > 1:
        print("too many classes found")
    print(clsmembers)
    print(clsmembers[0][1])
    x = clsmembers[0][1]("plop")
    print(x)
    x.run()

if __name__ == "__main__":
    main()
