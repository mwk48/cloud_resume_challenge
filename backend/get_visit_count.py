import json
import boto3

client = boto3.client('dynamodb')


def lambda_handler(event, context):
    id = event.get('queryStringParameters', {}).get('id', '0')
    data = client.get_item(
        TableName='visit_count',
        Key={
            'id': {
                'N': id
            }
        }
    )
    return {
        'statusCode': 200,
        'isBase64Encoded': False,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',  # CORS
        },
        'body': json.dumps(
            {
                'count': int(data.get('Item', {}).get('count', {}).get('N', int(id))),
                'id': int(id)
            }
        )
    }
