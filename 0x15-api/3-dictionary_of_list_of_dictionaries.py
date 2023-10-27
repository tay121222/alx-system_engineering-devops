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


def get_todo():
    """Fetch to task done by employee"""
    all_todos = {}
    users = requests.get('{}/users'.format(base_url)).json()

    for user in users:
        user_id = user['id']
        todos = requests.get('{}/todos?userId={}'.format(
            base_url, user_id)
            ).json()
        all_todos[user_id] = []
        for todo in todos:
            all_todos[user_id].append({
                "username": user['username'],
                "task": todo['title'],
                "completed": todo['completed']
            })
    with open('todo_all_employees.json', 'w') as f:
        json.dump(all_todos, f)


if __name__ == "__main__":
    get_todo()
