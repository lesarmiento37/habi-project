import json
import pymysql
import os

endpoint = os.environ.get('DB_HOST')
username = os.environ.get('DB_USER')
password = os.environ.get('DB_PASSWORD')
database = os.environ.get('DB_NAME')

def lambda_handler(event, context):
    connection = pymysql.connect(endpoint, user=username, passwd=password, db=database)
    cursor = connection.cursor()
    for record in event['Records']:
        payload = json.loads(record['body'])
        id = payload['id']
        data = payload['data']
        sql = "INSERT INTO your_table (id, data) VALUES (%s, %s)"
        cursor.execute(sql, (id, data))
    connection.commit()
    cursor.close()
    connection.close()
    return {'statusCode': 200, 'body': json.dumps('Data inserted')}
