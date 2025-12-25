import json
import uuid
import datetime
from flask import Request
from utils import get_db, get_headers

def create_item(request: Request):
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

        # Menggunakan utils helper
        collection = get_db()
        collection.document(item_id).set(item)

        return (json.dumps({'message': 'Item created successfully', 'item': item}), 201, get_headers('POST, OPTIONS'))

    except Exception as e:
        print(f"Error creating item: {e}")
        return (json.dumps({'message': 'Failed to create item', 'error': str(e)}), 500, get_headers('POST, OPTIONS'))