import json
import os
import uuid
import datetime
from flask import Request
from google.cloud import firestore


def create_item(request: Request):
    """HTTP Cloud Function to create an item in Firestore.

    Expects JSON body with optional fields: name, description, quantity, price, category, imageUrl
    Environment variable: FIRESTORE_COLLECTION (defaults to 'items')
    """
    # Handle CORS preflight
    if request.method == 'OPTIONS':
        return ('', 204, get_headers('POST, OPTIONS'))

    try:
        body = request.get_json(silent=True) or {}
        item_id = str(uuid.uuid4())
        timestamp = datetime.datetime.utcnow().isoformat() + 'Z'

        item = {
            'itemId': item_id,
            'name': body.get('name'),
            'description': body.get('description'),
            'quantity': int(body.get('quantity', 0)),
            'price': float(body.get('price', 0)),
            'category': body.get('category'),
            'imageUrl': body.get('imageUrl'),
            'createdAt': timestamp,
            'updatedAt': timestamp
        }

        client = firestore.Client()
        collection = os.environ.get('FIRESTORE_COLLECTION', 'items')
        client.collection(collection).document(item_id).set(item)

        return (json.dumps({'message': 'Item created successfully', 'item': item}), 201, get_headers('POST, OPTIONS'))

    except Exception as e:
        print(f"Error creating item: {e}")
        return (json.dumps({'message': 'Failed to create item', 'error': str(e)}), 500, get_headers('POST, OPTIONS'))


def get_headers(allowed_methods: str = 'GET, POST, OPTIONS'):
    return {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': allowed_methods,
        'Access-Control-Allow-Headers': 'Content-Type'
    }