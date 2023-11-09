#!/usr/bin/python3
"""contains function that queries the Reddit API"""
import requests

USER_AGENT = 'Mozilla/5.0'
URL_TEMPLATE = "https://www.reddit.com/r/{}/about.json"


def number_of_subscribers(subreddit):
    """function that queries the Reddit API
    and returns the number of subscribers"""

    try:
        url = URL_TEMPLATE.format(subreddit)
        headers_agent = {'User-Agent': USER_AGENT}
        response = requests.get(url, headers=headers_agent)
        if response.status_code == 200:
            return response.json()['data']['subscribers']
        else:
            0
    except requests.RequestException as e:
        return 0
