import React from 'react';
import LoginForm from './components/login/LoginForm.js'
import Entries from './components/entries/Entries.js'

function App() {
  function isLoggedIn() {
    return localStorage.getItem('isLoggedIn')
  }

 return (
   <div>
     {isLoggedIn() ? (
       <Entries/>
     ) : (
       <LoginForm/>
     )}
   </div>
  )
}

export default App;
