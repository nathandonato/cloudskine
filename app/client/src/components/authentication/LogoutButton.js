import React from 'react';

function LogoutButton() {

  function handleClick(event) {
    event.preventDefault();
    fetch(`${window.location.origin}/api/v1/logout`, {
      method: 'DELETE',
      credentials: 'include',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    })
    .then((response) => {
      if (response.ok) {
        localStorage.removeItem('isLoggedIn');
      }
    })
  };

  return (
    <button onClick={handleClick}>Logout</button>
  )
}

export default LogoutButton;
