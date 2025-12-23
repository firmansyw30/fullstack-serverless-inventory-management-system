import json
import os
from flask import Request
from google.cloud import firestore


def get_items(request: Request):
    """HTTP Cloud Function to retrieve items from Firestore.

    If query parameter itemId is provided, returns that item; otherwise returns all items.
    """
    # Handle CORS preflight
    if request.method == 'OPTIONS':
        return ('', 204, get_headers('GET, OPTIONS'))

    try:
        client = firestore.Client()
        collection = os.environ.get('FIRESTORE_COLLECTION', 'items')

        item_id = request.args.get('itemId')
        if item_id:
            doc = client.collection(collection).document(item_id).get()
            if not doc.exists:
                return (json.dumps({'message': 'Item not found'}), 404, get_headers('GET, OPTIONS'))
            return (json.dumps({'item': doc.to_dict()}), 200, get_headers('GET, OPTIONS'))

        # Get all items
        docs = client.collection(collection).stream()
        items = [d.to_dict() for d in docs]

        return (json.dumps({'items': items}), 200, get_headers('GET, OPTIONS'))

    except Exception as e:
        print(f"Error retrieving items: {e}")
        return (json.dumps({'message': 'Failed to retrieve items', 'error': str(e)}), 500, get_headers('GET, OPTIONS'))


def get_headers(allowed_methods: str = 'GET, OPTIONS'):
    return {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': allowed_methods,
        'Access-Control-Allow-Headers': 'Content-Type'
    }