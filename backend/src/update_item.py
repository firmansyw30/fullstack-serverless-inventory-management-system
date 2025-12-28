import json
import datetime
from utils import get_db, get_item_id, cors_response

def update_item(request):
    if request.method == "OPTIONS":
        return cors_response(status=204)

    try:
        body = request.get_json(silent=True) or {}
        item_id = get_item_id(request) or body.get("itemId")

        if not item_id:
            return cors_response(
                json.dumps({"message": "itemId is required"}), status=400
            )

        collection = get_db()
        doc_ref = collection.document(item_id)

        if not doc_ref.get().exists:
            return cors_response(
                json.dumps({"message": "Item not found"}), status=404
            )

        update_fields = {}
        for field in ["name", "description", "quantity", "price", "category", "imageUrl"]:
            if field in body:
                update_fields[field] = body[field]

        update_fields["updatedAt"] = datetime.datetime.utcnow().isoformat() + "Z"

        if update_fields:
            doc_ref.update(update_fields)

        updated_item = doc_ref.get().to_dict()
        return cors_response(
            json.dumps({"message": "Item updated successfully", "item": updated_item})
        )

    except Exception as e:
        return cors_response(
            json.dumps({"message": "Failed to update item", "error": str(e)}),
            status=500,
        )
