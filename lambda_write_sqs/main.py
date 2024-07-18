import json
import boto3
import os

sqs = boto3.client('sqs')
queue_url = os.environ.get('QUEUE_URL')

def lambda_handler(event, context):
    message = {
        'id': '1',
        'data': 'Sample event data'
    }
    response = sqs.send_message(
        QueueUrl=queue_url,
        MessageBody=json.dumps(message)
    )
    return response
