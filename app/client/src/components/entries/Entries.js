import React from 'react';

class Entries extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      entries: []
    };
  }

  componentDidMount() {
    fetch(`${window.location.origin}/api/v1/entries`, {
      method: 'GET',
      credentials: 'include',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    })
    .then(response => response.json())
    .then((data) => {
      this.setState({ entries: data })
    });
  }

  render() {
    const { entries } = this.state

    const listItems = entries.map((entry) =>
      <li key={entry.id}>
        <a href='' onClick={() => alert(entry.body)}>{entry.day}</a>
      </li>
    );

    return (
      <ul>
        {listItems}
      </ul>
    )
  }
}

export default Entries;
