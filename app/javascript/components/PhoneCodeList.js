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
    console.log(this.state.phone_codes)
    const listItems = this.state.phone_codes.map(code =>
      <tr key={code.id}>
        <td>{code.attributes.prefix}</td>
        <td>{code.attributes["min-len"]}</td>
        <td>{code.attributes["max-len"]}</td>
        <td>{code.attributes.usage}</td>
        <td>{code.attributes.comment}</td>
      </tr>
    );

    return(
      <table className="table">
        <thead>
          <tr>
            <th scope="col">Prefix</th>
            <th scope="col">min_len</th>
            <th scope="col">max_len</th>
            <th scope="col">usage</th>
            <th scope="col">comment</th>
          </tr>
        </thead>
        <tbody>
          {listItems}
        </tbody>
      </table>
    )
  }
}

export default PhoneCodeList;
