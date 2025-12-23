import json
import os
import datetime
from flask import Request
from google.cloud import firestore


def update_item(request: Request):
    """HTTP Cloud Function to update an item in Firestore.

    Expects JSON body with itemId and any updatable fields.
    """
    if request.method == 'OPTIONS':
        return ('', 204, get_headers('PUT, OPTIONS'))

    try:
        body = request.get_json(silent=True) or {}
        item_id = body.get('itemId')
        if not item_id:
            return (json.dumps({'message': 'itemId is required'}), 400, get_headers('PUT, OPTIONS'))

        client = firestore.Client()
        collection = os.environ.get('FIRESTORE_COLLECTION', 'items')
        doc_ref = client.collection(collection).document(item_id)
        if not doc_ref.get().exists:
            return (json.dumps({'message': 'Item not found'}), 404, get_headers('PUT, OPTIONS'))

        updateable_fields = ['name', 'description', 'quantity', 'price', 'category', 'imageUrl']
        updates = {}
        for field in updateable_fields:
            if field in body:
                # Ensure correct types
                if field == 'quantity':
                    updates[field] = int(body.get(field, 0))
                elif field == 'price':
                    updates[field] = float(body.get(field, 0))
                else:
                    updates[field] = body.get(field)

        updates['updatedAt'] = datetime.datetime.utcnow().isoformat() + 'Z'

        if updates:
            doc_ref.update(updates)

        updated_doc = doc_ref.get().to_dict()
        return (json.dumps({'message': 'Item updated successfully', 'item': updated_doc}), 200, get_headers('PUT, OPTIONS'))

    except Exception as e:
        print(f"Error updating item: {e}")
        return (json.dumps({'message': 'Failed to update item', 'error': str(e)}), 500, get_headers('PUT, OPTIONS'))


def get_headers(allowed_methods: str = 'GET, PUT, OPTIONS'):
    return {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': allowed_methods,
        'Access-Control-Allow-Headers': 'Content-Type'
    }