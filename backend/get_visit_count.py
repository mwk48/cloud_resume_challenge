import json
import boto3

client = boto3.client('dynamodb')


def lambda_handler(event, context):
    data = client.get_item(
        TableName='visit_count',
        Key={
            'id': {
                'N': '0'
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
                'count': int(data.get('Item', {}).get('count', {}).get('N', 0)),
                'id': 0
            }
        )
    }
