import json
import os
from flask import Request
from google.cloud import firestore


def delete_item(request: Request):
    """HTTP Cloud Function to delete an item from Firestore.

    Expects query parameter: itemId
    """
    # Handle CORS preflight
    if request.method == 'OPTIONS':
        return ('', 204, get_headers('DELETE, OPTIONS'))

    try:
        item_id = request.args.get('itemId')
        if not item_id:
            return (json.dumps({'message': 'itemId is required'}), 400, get_headers('DELETE, OPTIONS'))

        client = firestore.Client()
        collection = os.environ.get('FIRESTORE_COLLECTION', 'items')
        doc_ref = client.collection(collection).document(item_id)
        doc = doc_ref.get()

        if not doc.exists:
            return (json.dumps({'message': 'Item not found'}), 404, get_headers('DELETE, OPTIONS'))

        deleted_item = doc.to_dict()
        doc_ref.delete()

        return (json.dumps({'message': 'Item deleted successfully', 'item': deleted_item}), 200, get_headers('DELETE, OPTIONS'))

    except Exception as e:
        print(f"Error deleting item: {e}")
        return (json.dumps({'message': 'Failed to delete item', 'error': str(e)}), 500, get_headers('DELETE, OPTIONS'))


def get_headers(allowed_methods: str = 'GET, DELETE, OPTIONS'):
    return {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': allowed_methods,
        'Access-Control-Allow-Headers': 'Content-Type'
    }