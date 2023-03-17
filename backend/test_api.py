import requests
import pytest

base_url = "https://w9ekkp4ntk.execute-api.us-east-1.amazonaws.com/v1"


def test_api_get():
    response = requests.get(base_url)
    assert response.status_code == 200
    assert isinstance(response.json()['body']['count'], int)


def test_api_put():
    original_count = requests.get(base_url).json()['body']['count']
    response = requests.put(base_url)
    assert response.status_code == 200
    assert response.json()['count'] == original_count + 1
