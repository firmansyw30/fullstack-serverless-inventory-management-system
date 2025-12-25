import json
from flask import Request
from utils import get_db, get_headers, get_item_id

def delete_item(request: Request):
    if request.method == 'OPTIONS':
        return ('', 204, get_headers('DELETE, OPTIONS'))     
    try:
        # MENGGUNAKAN HELPER (Fix bug logika ada di dalam helper)
        item_id = get_item_id(request)

        if not item_id:
            return (json.dumps({'message': 'itemId is required'}), 400, get_headers('DELETE, OPTIONS'))

        collection = get_db()
        doc_ref = collection.document(item_id)
        doc = doc_ref.get()

        if not doc.exists:
            return (json.dumps({'message': 'Item not found'}), 404, get_headers('DELETE, OPTIONS'))

        deleted_item = doc.to_dict()
        doc_ref.delete()

        return (json.dumps({'message': 'Item deleted successfully', 'item': deleted_item}), 200, get_headers('DELETE, OPTIONS'))

    except Exception as e:
        print(f"Error deleting item: {e}")
        return (json.dumps({'message': 'Failed to delete item', 'error': str(e)}), 500, get_headers('DELETE, OPTIONS'))