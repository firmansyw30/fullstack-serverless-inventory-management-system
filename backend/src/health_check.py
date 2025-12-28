import json
import datetime
from utils import get_db, cors_response

def health_check(request):
    if request.method == "OPTIONS":
        return cors_response(status=204)

    try:
        collection = get_db()
        docs = list(collection.limit(1).stream())

        payload = {
            "status": "ok",
            "checkedAt": datetime.datetime.utcnow().isoformat() + "Z",
            "collection": collection.id,
            "sampleFound": len(docs) > 0,
        }

        return cors_response(json.dumps(payload))

    except Exception as e:
        return cors_response(
            json.dumps({"status": "error", "error": str(e)}), status=500
        )
