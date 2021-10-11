from engine_nxc import NXCEngine
from driver import Machine, Nodes

def main():
    e = NXCEngine()

    e.run()

    e.plop = "plop"
    print(e.plop)

    machine_foo = Machine("foo")
    machine_bar = Machine("bar")

    machines = {
        "foo" : machine_foo,
        "bar" : machine_bar
    }

    e.nodes = Nodes(machines)

    print(e.nodes.foo.whoami())
    print(e.nodes.bar.whoami())

if __name__ == "__main__":
    main()
