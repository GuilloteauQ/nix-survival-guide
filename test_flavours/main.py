"""
Test from driver runner
"""
import json
import importlib.machinery
import importlib.util
from pathlib import Path
from mother_driver import MotherDriver


def get_driver():
    """
    Get the path to the driver file
    """
    with open("result", "r") as result:
        data = json.load(result)
        return data["driver"]

def get_driver_module(driver_path):
    """
    Loads the driver
    """
    # Get path to mymodule
    module = driver_path.split('/')[-1]
    loader = importlib.machinery.SourceFileLoader(module, driver_path)
    spec = importlib.util.spec_from_loader(module, loader)
    return loader, importlib.util.module_from_spec(spec)

def load_module(loader, module):
    """
    Loads the module of the driver
    """
    loader.exec_module(module)

def main():
    """
    Main function
    """
    driver_path = get_driver()

    loader, driver_module = get_driver_module(driver_path)
    load_module(loader, driver_module)

    driver = driver_module.Driver()

    driver.hello()


    return 0;

if __name__ == "__main__":
    main()
