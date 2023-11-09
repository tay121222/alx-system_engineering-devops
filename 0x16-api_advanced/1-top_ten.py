#!/usr/bin/python3
"""contains function that queries the Reddit API"""
import requests

USER_AGENT = 'Mozilla/5.0'
URL_TEMPLATE = "https://www.reddit.com/r/{}/hot.json"


def top_ten(subreddit):
    """function that queries the Reddit API and prints the titles
    of the first 10 hot posts listed for a given subreddit"""
    try:
        url = URL_TEMPLATE.format(subreddit)
        headers = {'User-Agent': USER_AGENT}
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            data = response.json()
            posts = data['data']['children'][:10]
            for post in posts:
                print(post['data']['title'])
        else:
            print(None)
    except requests.RequestException as e:
        print(None)
