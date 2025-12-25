import os
from google.cloud import firestore

def get_db():
    """Singleton-like Firestore client provider."""
    # Cloud Functions reuses global variables across invocations (warm start)
    # But for safety, we instantiate client here.
    collection_name = os.environ.get("FIRESTORE_COLLECTION", "items")
    client = firestore.Client()
    return client.collection(collection_name)

def get_headers(allowed_methods: str = 'GET, OPTIONS'):
    """Standardized CORS headers."""
    return {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': allowed_methods,
        'Access-Control-Allow-Headers': 'Content-Type, Authorization, x-api-key'
    }

def get_item_id(request):
    """Helper to extract itemId from Query Param OR URL Path."""
    # 1. Try Query Param
    item_id = request.args.get('itemId')
    
    # 2. Try Path Fallback
    if not item_id:
        path_segments = request.path.strip('/').split('/')
        if path_segments:
            # Mengambil segmen terakhir sebagai ID
            item_id = path_segments[-1]
            
    return item_id