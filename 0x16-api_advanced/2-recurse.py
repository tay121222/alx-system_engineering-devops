#!/usr/bin/python3
"""contains function that queries the Reddit API"""
import requests

USER_AGENT = 'Mozilla/5.0'
URL_TEMPLATE = "https://www.reddit.com/r/{}/hot.json"


def recurse(subreddit, hot_list=None, after=None):
    """Write a recursive function that queries the Reddit API and
    returns a list containing the titles of all hot articles for a
    given subreddit"""
    if hot_list is None:
        hot_list = []

    try:
        url = URL_TEMPLATE.format(subreddit)
        headers = {'User-Agent': USER_AGENT}
        params = {'limit': 100, 'after': after} if after else {'limit': 100}
        response = requests.get(url, headers=headers, params=params,
                                allow_redirects=False)

        if response.status_code != 200:
            return None

        data = response.json()
        posts = data['data']['children']

        for post in posts:
            hot_list.append(post['data']['title'])

        after = data['data']['after']
        if after:
            return recurse(subreddit, hot_list, after)

        return hot_list

    except requests.RequestException as e:
        return None
