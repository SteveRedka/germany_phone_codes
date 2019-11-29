import React from 'react'
import {mount, shallow, render, configure} from 'enzyme'
import PhoneCodeList from 'components/PhoneCodeList.js'
import Adapter from 'enzyme-adapter-react-16';
global.fetch = require('jest-fetch-mock')

configure({ adapter: new Adapter() })
const wrapper = mount(<PhoneCodeList />);

describe('Phone list', function() {
  beforeEach(() => {
    fetch.resetMocks()
  })

  test('Renders static table', () => {
    expect(render(wrapper).find('.phone-code-table').length).toBeGreaterThan(0);
  })

  test('Lists at least one phone code from database', async () => {
    var fakeResponse = JSON.stringify({ data: [{id: 1, attributes: { prefix: 'foo'}},
                                               {id: 2, attributes: { prefix: 'bar'}}]})
    var fetch = jest.fn()
    fetch.mockReturnValue(Promise.resolve(fakeResponse));

    var resp = await render(wrapper);
    expect(fetch.mock.calls.length).toEqual(1)
    expect(resp.find('.phone-code-row').length).toBeGreaterThan(0);
  })
})
