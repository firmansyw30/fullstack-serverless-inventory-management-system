import json
from utils import get_db, cors_response

def get_items(request):
    if request.method == "OPTIONS":
        return cors_response(status=204)

    try:
        collection = get_db()
        item_id = request.args.get("itemId")

        if item_id:
            doc = collection.document(item_id).get()
            if not doc.exists:
                return cors_response(
                    json.dumps({"message": "Item not found"}), status=404
                )
            return cors_response(json.dumps({"item": doc.to_dict()}))

        docs = collection.stream()
        items = [{**d.to_dict(), "itemId": d.id} for d in docs]

        return cors_response(json.dumps({"items": items}))

    except Exception as e:
        return cors_response(
            json.dumps({"message": "Failed to retrieve items", "error": str(e)}),
            status=500,
        )
