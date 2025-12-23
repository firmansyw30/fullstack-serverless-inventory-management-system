import json
import os
import datetime
from flask import Request
from google.cloud import firestore


def health_check(request: Request):
    """Simple health check Cloud Function for Firestore connectivity.

    - Returns 200 when a simple read from the configured collection succeeds.
    - Returns 500 with error details when the check fails.
    """
    # Handle CORS preflight
    if request.method == 'OPTIONS':
        return ('', 204, get_headers())

    collection = os.environ.get('FIRESTORE_COLLECTION', 'items')
    try:
        client = firestore.Client()
        # Try a light read (limit 1) to verify connectivity and permissions
        docs = list(client.collection(collection).limit(1).stream())

        payload = {
            'status': 'ok',
            'checkedAt': datetime.datetime.utcnow().isoformat() + 'Z',
            'collection': collection,
            'sampleFound': len(docs) > 0,
            'project': client.project
        }

        return (json.dumps(payload), 200, get_headers())

    except Exception as e:
        print(f"Health check error: {e}")
        return (json.dumps({'message': 'Health check failed', 'error': str(e)}), 500, get_headers())


def get_headers(allowed_methods: str = 'GET, OPTIONS'):
    return {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': allowed_methods,
        'Access-Control-Allow-Headers': 'Content-Type'
    }
