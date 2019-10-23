import React from 'react';
import { Button, FormGroup, FormControl, FormLabel } from 'react-bootstrap';

class LoginForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      user: {
        password: '',
        email: ''
      }
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.missingRequiredFields = this.missingRequiredFields.bind(this);
  }

  missingRequiredFields() {
    const { email, password } = this.state.user;
    return (email.length === 0 || password.length === 0);
  }

  handleChange(event) {
    this.setState({ user: { ...this.state.user, [event.target.name]: event.target.value} });
  }

  handleSubmit(event) {
    event.preventDefault();
    fetch(`${window.location.origin}/api/v1/login`, {
      method: 'POST',
      credentials: 'include',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(this.state)
    })
    .then(response => response.json())
    .then(data => {
      console.log('you are logged in')
      localStorage.setItem('isLoggedIn', true)
    });
  }

  render() {
    const { email, password } = this.state.user;

    return (
      <div className='Login'>
        <form onSubmit={this.handleSubmit}>
          <FormGroup controlId='email'>
            <FormLabel>Email</FormLabel>
            <FormControl
              autoFocus
              name='email'
              type='email'
              value={email}
              onChange={this.handleChange}
            />
          </FormGroup>
          <FormGroup controlId='password'>
            <FormLabel>Password</FormLabel>
            <FormControl
              name='password'
              value={password}
              onChange={this.handleChange}
              type='password'
            />
          </FormGroup>
          <Button block disabled={this.missingRequiredFields()} type='submit'>
            Login
          </Button>
        </form>
      </div>
    );
  }
}

export default LoginForm;
