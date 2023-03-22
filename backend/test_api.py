import requests
import pytest

base_url = "https://kbdsejhdtd.execute-api.us-east-1.amazonaws.com/v1"


def test_api_put():
    response1 = requests.put(base_url, params={'id': '1'})
    response2 = requests.put(base_url, params={'id': '1'})
    assert response1.status_code == 200
    assert response2.status_code == 200
    assert response1.json()['count']+1 == response2.json()['count']


def test_api_error():
    response1 = requests.put(base_url, params={'id': '2'})
    assert response1.status_code == 400
    assert response1.json()['message'] == 'Invalid id'
