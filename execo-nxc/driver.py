class Machine:
    def __init__(self, name):
        self.name = name

    def whoami(self):
        return self.name

class Nodes:
    def __init__(self, machines):
        cmd_engine_field = [
            f"self.{machine_name} = machines['{machine_name}']" for machine_name in machines
        ]
        exec("\n".join(cmd_engine_field))
