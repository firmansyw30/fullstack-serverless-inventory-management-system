"""
Main entry point for Cloud Functions.
This file imports all function handlers to make them discoverable by Cloud Functions runtime.
"""

# Import all function handlers
from create_item import create_item
from get_items import get_items
from update_item import update_item
from delete_item import delete_item
from health_check import health_check

# Export all functions
__all__ = [
    'create_item',
    'get_items',
    'update_item',
    'delete_item',
    'health_check'
]
