import React from 'react';
import '../src/App.css';
function Header({ onAddNewClick }) {
  const handleHomeClick = () => {
    console.log('Home button clicked');
    window.location.href = '/';
  };
  return (
    <header className="header">
      <button className="home-button" onClick={handleHomeClick}>
        <h1>Simple Inventory Management System</h1>
      </button>
      <button className="add-button" onClick={onAddNewClick}>Add New Item</button>
    </header>
  );
}

export default Header;