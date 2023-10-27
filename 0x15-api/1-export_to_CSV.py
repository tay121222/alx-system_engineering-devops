#!/usr/bin/python3
"""
Retrieves information about employee TODO list progress from a REST API.

Usage:
python3 filename.py <employee_id>
"""
import csv
import requests
import sys

base_url = "https://jsonplaceholder.typicode.com"


def get_todo(id):
    """Fetch to task done by employee"""
    employee_id = id
    url = "{}/users/{}".format(base_url, employee_id)
    response = requests.get(url)
    employee = response.json()
    employee_name = employee["username"]

    url = "{}/todos?userId={}".format(base_url, employee_id)
    response = requests.get(url)
    todos = response.json()

    file_name = "{}.csv".format(employee_id)
    with open(file_name, mode="w", newline="") as file:
        writer = csv.writer(file, quoting=csv.QUOTE_ALL)
        # writer.writerow(
        #        ["USER_ID", "USERNAME", "TASK_COMPLETED_STATUS", "TASK_TITLE"]
        #        )
        for todo in todos:
            row = [
                str(todo["userId"]),
                employee_name,
                str(todo["completed"]),
                todo["title"],
            ]
            writer.writerow(row)

    print("Employee {} tasks saved to {}".format(employee_name, file_name))


if __name__ == "__main__":
    get_todo(int(sys.argv[1]))
