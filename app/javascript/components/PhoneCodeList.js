import React, { useEffect, useState } from "react";

class PhoneCodeList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {phone_codes: []};
  }

  async loadCodes() {
    var phoneCodeField = document.getElementById('phone-code-search-input')
    const response = await fetch(`/api/phone-codes?filter[search]=${phoneCodeField.value}`);
    const data = await response.json();
    this.setState({phone_codes: data.data})
  }

  render() {
    const listItems = this.state.phone_codes.map(code =>
      <tr key={code.id}>
        <td>{code.attributes.prefix}</td>
        <td>{code.attributes["min-len"]}</td>
        <td>{code.attributes["max-len"]}</td>
        <td>{code.attributes.usage}</td>
        <td>{code.attributes.comment}</td>
      </tr>
    );

    const form =
      <form onSubmit={this.loadCodes.bind(this)}>
        <label>
          Name:
          <input type="text" id="phone-code-search-input" onChange={this.loadCodes.bind(this)} />
        </label>
        <input type="submit" value="Submit" />
      </form>

    return(
      <div>
        {form}
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
      </div>
    )
  }
}

export default PhoneCodeList;
