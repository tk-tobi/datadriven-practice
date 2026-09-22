from collections import deque
def resolve_order(tasks: dict) -> list:
    # tasks[node] lists prerequisites that must run BEFORE node.
    in_degree = {node: 0 for node in tasks}
    dependents = {node: [] for node in tasks}
    for node in tasks:
        for prereq in tasks[node]:
            # A prereq referenced but not a key is a task with no deps.
            if prereq not in in_degree:
                in_degree[prereq] = 0
                dependents[prereq] = []
            dependents[prereq].append(node)
            in_degree[node] += 1
    queue = deque(node for node in in_degree if in_degree[node] == 0)
    order = []
    while queue:
        node = queue.popleft()
        order.append(node)
        for dependent in dependents[node]:
            in_degree[dependent] -= 1
            if in_degree[dependent] == 0:
                queue.append(dependent)
    if len(order) != len(in_degree):
        raise ValueError("Cycle detected in dependency graph")
    return order
