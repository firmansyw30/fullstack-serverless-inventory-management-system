# # Load dotenv ONLY for local development
# if os.environ.get("ENV", "local") == "local":
#     try:
#         from dotenv import load_dotenv
#         load_dotenv()
#     except ImportError:
#         pass

# def get_db():
#     """
#     Firestore collection provider
#     - Cloud Functions: ENV injected by Terraform
#     - Local: .env file
#     """

#     # ⚠️ IMPORTANT:
#     # Firestore SDK in Cloud Functions should USE DEFAULT DATABASE
#     # Do NOT force custom database here
#     #client = firestore.Client()
#     client = firestore.Client(database="inventory-db")

#     collection_name = os.environ.get("FIRESTORE_COLLECTION", "items")
#     database_name = os.environ.get("FIRESTORE_DATABASE")  # optional
#     #database_name = os.environ.get("FIRESTORE_DATABASE", "inventory-db")

#     #client = firestore.Client(database=database_name)
#     return client.collection(collection_name)

import os
from google.cloud import firestore

def get_db():
    collection_name = os.environ.get("FIRESTORE_COLLECTION", "items")
    database_name = os.environ.get("FIRESTORE_DATABASE")

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
