import json
import uuid
import datetime
from utils import get_db, cors_response

def create_item(request):
    if request.method == "OPTIONS":
        return cors_response(status=204)

    try:
        body = request.get_json(silent=True) or {}

        item_id = str(uuid.uuid4())
        now = datetime.datetime.utcnow().isoformat() + "Z"

        item = {
            "itemId": item_id,
            "name": body.get("name"),
            "description": body.get("description"),
            "quantity": int(body.get("quantity", 0)),
            "price": float(body.get("price", 0)),
            "category": body.get("category"),
            "imageUrl": body.get("imageUrl"),
            "createdAt": now,
            "updatedAt": now,
        }

        get_db().document(item_id).set(item)

        return cors_response(
            json.dumps({"message": "Item created successfully", "item": item}),
            status=201,
        )

    except Exception as e:
        return cors_response(
            json.dumps({"message": "Failed to create item", "error": str(e)}),
            status=500,
        )
