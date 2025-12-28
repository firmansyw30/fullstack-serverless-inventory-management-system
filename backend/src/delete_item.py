import json
from utils import get_db, get_item_id, cors_response

def delete_item(request):
    if request.method == "OPTIONS":
        return cors_response(status=204)

    try:
        item_id = get_item_id(request)

        if not item_id:
            return cors_response(
                json.dumps({"message": "itemId is required"}), status=400
            )

        collection = get_db()
        doc_ref = collection.document(item_id)
        doc = doc_ref.get()

        if not doc.exists:
            return cors_response(
                json.dumps({"message": "Item not found"}), status=404
            )

        deleted_item = doc.to_dict()
        doc_ref.delete()

        return cors_response(
            json.dumps({"message": "Item deleted successfully", "item": deleted_item})
        )

    except Exception as e:
        return cors_response(
            json.dumps({"message": "Failed to delete item", "error": str(e)}),
            status=500,
        )
