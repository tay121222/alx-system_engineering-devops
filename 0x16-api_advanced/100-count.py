#!/usr/bin/python3
"""contains function that queries the Reddit API"""
import requests

USER_AGENT = 'Mozilla/5.0'
URL_TEMPLATE = "https://www.reddit.com/r/{}/hot.json"


def count_words(subreddit, word_list, counts=None, after=None):
    """recursive function that queries the Reddit API, parses the
    title of all hot articles, and prints a sorted count of given
    keywords"""
    if counts is None:
        counts = {}

    try:
        url = URL_TEMPLATE.format(subreddit)
        headers = {'User-Agent': USER_AGENT}
        params = {'limit': 100, 'after': after} if after else {'limit': 100}
        response = requests.get(url, headers=headers, params=params, allow_redirects=False)

        if response.status_code != 200:
            return

        data = response.json()
        if 'data' not in data or 'children' not in data['data']:
            return

        posts = data['data']['children']

        for post in posts:
            title = post['data']['title'].lower()
            for word in word_list:
                word_lower = word.lower()
                if word_lower in title:
                    counts[word_lower] = counts.get(word_lower, 0) + title.count(word_lower)

        after = data['data']['after']
        if after:
            count_words(subreddit, word_list, counts, after)

        if not after:
            print_results(counts)

    except requests.RequestException as e:
        return


def print_results(counts):
    sorted_counts = sorted(counts.items(), key=lambda x: (-x[1], x[0]))
    for word, count in sorted_counts:
        print(f"{word}: {count}")
