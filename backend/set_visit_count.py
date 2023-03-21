import json
import boto3

client = boto3.client('dynamodb')
lambda_client = boto3.client('lambda')


def lambda_handler(event, context):
    id = event.get('queryStringParameters', {}).get('id', '0')
    if not (id == '0' or id == '1'):
        return {
            'statusCode': 400,
            'isBase64Encoded': False,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',  # CORS
            },
            'body': json.dumps(
                {
                    'message': 'Invalid id',
                }
            )
        }
    data = lambda_client.invoke(FunctionName='get_visit_count',
                                InvocationType='RequestResponse', Payload=json.dumps(event))
    # print(data.keys())
    # print(data['Payload'])
    json_data = json.loads(data['Payload'].read())
    body = json.loads(json_data['body'])
    count = body['count']
    client.put_item(TableName='visit_count', Item={
                    'id': {'N': str(id)}, 'count': {'N': str(count+1)}})
    return {
        'statusCode': 200,
        'isBase64Encoded': False,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',  # CORS
        },
        'body': json.dumps(
            {
                'count': count+1,
            }
        )
    }
