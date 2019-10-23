import React from 'react';
import LoginForm from './components/authentication/LoginForm.js'
import LogoutButton from './components/authentication/LogoutButton.js'
import Entries from './components/entries/Entries.js'

function App() {
  function isLoggedIn() {
    return localStorage.getItem('isLoggedIn')
  }

 return (
   <div className='app'>
     {isLoggedIn() ? (
       <div>
         <Entries/>
         <LogoutButton/>
       </div>
     ) : (
       <div>
         <LoginForm/>
       </div>
     )}
   </div>
  )
}

export default App;
