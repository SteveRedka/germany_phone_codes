import React, { useEffect, useState } from "react";
import { Pagination, Icon } from 'semantic-ui-react'

class PhoneCodeList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { phone_codes: [],
                   links: [],
                   windowParams: new URLSearchParams(window.location.search) };
  }

  componentDidMount() {
    var searchParams = new URLSearchParams(this.state.windowParams.toString())
    this.setState({ windowParams: searchParams })
  }

  async componentDidUpdate(prevProps, prevState) {
    if (this.state.windowParams != prevState.windowParams) {
      const response = await fetch(`/api/v1/phone-codes?${this.state.windowParams.toString()}`);
      const responseJson = await response.json();
      this.setState({phone_codes: responseJson.data, links: responseJson.links})
    }
  }

  async handleSearch(e) {
    var searchParams = new URLSearchParams(this.state.windowParams.toString())
    searchParams.set('filter[search]', e.target.value)
    this.setState({ windowParams: searchParams })
  }

  async handlePaginationChange (_e, { activePage }) {
    var searchParams = new URLSearchParams(this.state.windowParams.toString())
    searchParams.set('page[number]', activePage)
    this.setState({ windowParams: searchParams })
  }

  totalPages () {
    var lastLink = this.state.links['last']
    if (lastLink) {
      var param = lastLink.match(/page%5Bnumber%5D=\d*/)[0].replace(/page%5Bnumber%5D=/, '') || 1
      return parseInt(param)
    } else {
      return(1)
    }
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
      <div className="breadcrumb">
        <form className="form-group">
          <div className="form-row align-items-center">
            <div className="col-sm-8 col-sm-offset-2">
              <input type="text" id="phone-code-search-input" value={this.state.windowParams.get('filter[search]') || '' } onChange={this.handleSearch.bind(this)} className="form-control" placeholder="Enter search term or phone code" />
            </div>
          </div>
        </form>
        &nbsp;
      </div>

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
        <Pagination
          onPageChange={this.handlePaginationChange.bind(this)}
          defaultActivePage={1}
          firstItem={{ content: <Icon name='angle double left' />, icon: true }}
          lastItem={{ content: <Icon name='angle double right' />, icon: true }}
          prevItem={{ content: <Icon name='angle left' />, icon: true }}
          nextItem={{ content: <Icon name='angle right' />, icon: true }}
          totalPages={ this.totalPages() }
        />
      </div>
    )
  }
}

export default PhoneCodeList;
