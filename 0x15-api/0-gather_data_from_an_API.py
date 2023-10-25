#!/usr/bin/python3
"""returns information about employee TODO list progress"""
import requests
import sys


emp_id = sys.argv[1]
url = 'https://jsonplaceholder.typicode.com/users/{}'.format(emp_id)
response = requests.get(url)
employee = response.json()
employee_name = employee['name']


url = 'https://jsonplaceholder.typicode.com/todos?'
param = 'userId={}'.format(emp_id)
response = requests.get(url + param)
todos = response.json()
completed_tasks = [todo['title'] for todo in todos if todo['completed']]
total_tasks = len(todos)

print("Employee {} is done with tasks({}/{}):"
      .format(employee_name, len(completed_tasks), total_tasks))
for task in completed_tasks:
    print("\t{}".format(task))
