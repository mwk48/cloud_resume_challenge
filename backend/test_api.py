import requests
import pytest

base_url = "https://w9ekkp4ntk.execute-api.us-east-1.amazonaws.com/v1"


def test_api_put():
    response1 = requests.put(base_url)
    response2 = requests.put(base_url)
    assert response1.status_code == 200
    assert response2.status_code == 200
    assert response1.json()['count']+1 == response2.json()['count']
