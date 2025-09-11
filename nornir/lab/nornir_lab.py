from nornir import InitNornir
from nornir.core.task import Task, Result
import docker


def run_zebra(task: Task) -> Result:
    client = docker.from_env()
    container = client.containers.get(task.host.name)

    # Example: simple commands to Zebra via vtysh
    commands = [
        "configure terminal",
        f"hostname {task.host.name}",
    ]
    for cmd in commands:
        container.exec_run(f"vtysh -c \"{cmd}\"")

    return Result(host=task.host, result="FRR basic config applied")

# Initialize Nornir
nr = InitNornir(config_file="/opt/nornir/lab/inventory/config.yaml")

# Run the task on all hosts
result = nr.run(task=run_zebra)

# Print results
for host, task_result in result.items():
    print(host, task_result[0].result)