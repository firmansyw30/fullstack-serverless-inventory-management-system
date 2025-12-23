import json
import os
from datetime import datetime

import boto3
from botocore.exceptions import ClientError


def lambda_handler(event, context):
    """Simple health check Lambda.

    - Returns 200 + details when DynamoDB DescribeTable succeeds.
    - Returns 500 with error details when the check fails.

    Expected environment variable: DYNAMODB_TABLE
    Supports GET and OPTIONS (for CORS preflight).
    """
    # Handle CORS preflight
    http_method = event.get('httpMethod') or event.get('requestContext', {}).get('http', {}).get('method')
    if http_method == 'OPTIONS':
        return {
            'statusCode': 200,
            'headers': get_headers(),
            'body': json.dumps({'message': 'ok'})
        }

    table_name = os.environ.get('DYNAMODB_TABLE')
    if not table_name:
        return {
            'statusCode': 500,
            'headers': get_headers(),
            'body': json.dumps({'message': 'DYNAMODB_TABLE environment variable is not set'})
        }

    client = boto3.client('dynamodb')

    try:
        resp = client.describe_table(TableName=table_name)
        tbl = resp.get('Table', {})

        payload = {
            'status': 'ok',
            'checkedAt': datetime.utcnow().isoformat(),
            'table': {
                'name': table_name,
                'status': tbl.get('TableStatus'),
                'itemCount': tbl.get('ItemCount'),
                'sizeBytes': tbl.get('TableSizeBytes')
            },
            'region': client.meta.region_name
        }

        return {
            'statusCode': 200,
            'headers': get_headers(),
            'body': json.dumps(payload)
        }

    except ClientError as e:
        # AWS-side error (e.g., table not found or permission denied)
        print(f"DynamoDB ClientError: {e}")
        return {
            'statusCode': 500,
            'headers': get_headers(),
            'body': json.dumps({'message': 'DynamoDB describe_table failed', 'error': str(e)})
        }
    except Exception as e:
        # Generic error
        print(f"Health check error: {e}")
        return {
            'statusCode': 500,
            'headers': get_headers(),
            'body': json.dumps({'message': 'Health check failed', 'error': str(e)})
        }


def get_headers():
    return {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type'
    }
