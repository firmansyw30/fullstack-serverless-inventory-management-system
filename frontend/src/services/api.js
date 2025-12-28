const API_ENDPOINT = process.env.REACT_APP_API_ENDPOINT;
const API_KEY = process.env.REACT_APP_API_KEY;

if (!API_ENDPOINT || !API_KEY) {
  throw new Error('API configuration is missing');
}

const defaultHeaders = {
  'Content-Type': 'application/json',
  'x-api-key': API_KEY,
};

// =====================
// GET ALL ITEMS
// =====================
export async function fetchItems() {
  console.log('Fetching:', `${API_ENDPOINT}/items`);
  const response = await fetch(`${API_ENDPOINT}/items`, {
    headers: defaultHeaders,
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`API ${response.status}: ${text}`);
  }

  return response.json();
}

// =====================
// GET SINGLE ITEM
// =====================
export async function fetchItem(itemId) {
  const response = await fetch(
    `${API_ENDPOINT}/items?itemId=${itemId}`,
    { headers: defaultHeaders }
  );

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`API ${response.status}: ${text}`);
  }

  return response.json();
}

// =====================
// CREATE ITEM
// =====================
export async function createItem(itemData) {
  const response = await fetch(`${API_ENDPOINT}/items`, {
    method: 'POST',
    headers: defaultHeaders,
    body: JSON.stringify(itemData),
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`API ${response.status}: ${text}`);
  }

  return response.json();
}

// =====================
// UPDATE ITEM
// =====================
export async function updateItem(itemData) {
  const response = await fetch(
    `${API_ENDPOINT}/items/${itemData.itemId}`,
    {
      method: 'PUT',
      headers: defaultHeaders,
      body: JSON.stringify(itemData),
    }
  );

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`API ${response.status}: ${text}`);
  }

  return response.json();
}

// =====================
// DELETE ITEM
// =====================
export async function deleteItem(itemId) {
  const response = await fetch(
    `${API_ENDPOINT}/items/${itemId}`,
    {
      method: 'DELETE',
      headers: defaultHeaders,
    }
  );

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`API ${response.status}: ${text}`);
  }

  return response.json();
}

if (process.env.NODE_ENV === 'development') {
  console.log('API ENDPOINT:', API_ENDPOINT);
}
