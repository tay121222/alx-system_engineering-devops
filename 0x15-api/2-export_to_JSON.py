#!/usr/bin/python3
"""
Retrieves information about employee TODO list progress from a REST API.

Usage:
python3 filename.py <employee_id>
"""
import json
import requests
import sys

base_url = 'https://jsonplaceholder.typicode.com'


def get_todo(id):
    """Fetch to task done by employee"""
    employee_id = id
    url = '{}/users/{}'.format(base_url, employee_id)
    response = requests.get(url)
    employee = response.json()
    employee_name = employee['username']

    url = 'https://jsonplaceholder.typicode.com/todos?'
    param = 'userId={}'.format(employee_id)
    response = requests.get(url + param)
    todos = response.json()

    tasks = []
    for todo in todos:
        task = {
            "task": todo['title'],
            "completed": todo['completed'],
            "username": employee_name
        }
        tasks.append(task)

    data = {str(employee_id): tasks}
    filename = '{}.json'.format(employee_id)
    with open(filename, 'w') as f:
        json.dump(data, f)


if __name__ == "__main__":
    get_todo(int(sys.argv[1]))
