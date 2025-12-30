import os
from google.cloud import firestore

def get_db():
    collection_name = os.environ.get("FIRESTORE_COLLECTION", "items")
    database_name = os.environ.get("FIRESTORE_DATABASE", "inventory-db")

    if database_name:
        client = firestore.Client(database=database_name)
    else:
        client = firestore.Client()

    return client.collection(collection_name)


def get_item_id(request):
    # Query param
    item_id = request.args.get("itemId")

    # Path fallback (API Gateway style)
    if not item_id:
        segments = request.path.strip("/").split("/")
        if segments:
            item_id = segments[-1]

    return item_id


def cors_response(body=None, status=200):
    return (
        body or "",
        status,
        {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
            "Access-Control-Allow-Headers": "Content-Type, Authorization, x-api-key",
        },
    )
