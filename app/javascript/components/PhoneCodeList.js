import React, { useEffect, useState } from "react";

class PhoneCodeList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {phone_codes: []};
  }

  async loadCodes() {
    const response = await fetch("/api/phone-codes");
    const data = await response.json();
    this.setState({phone_codes: data.data})
  }

  componentDidMount() {
    this.loadCodes();
  }

  render() {
    const listItems = this.state.phone_codes.map(code =>
      <li key={code.id}>{code.attributes.prefix}</li>
    );

    return(
      <ul>{listItems}</ul>
    )
  }
}

export default PhoneCodeList;
