import React from 'react'
import {mount, shallow, render, configure} from 'enzyme'
import PhoneCodeList from 'components/PhoneCodeList.js'
import Adapter from 'enzyme-adapter-react-16';
import "isomorphic-fetch"

global.fetch = jest.fn().mockImplementation(() => mockFetchPromise);

configure({ adapter: new Adapter() })
const wrapper = mount(<PhoneCodeList />);

describe('Phone list', function() {
  test('Renders static table', () => {
    expect(render(wrapper).find('.phone-code-table').length).toBeGreaterThan(0);
  })

  test('Lists at least one phone code from database', async () => {
    // expect(await render(wrapper).find('.phone-code-row').length).toBeGreaterThan(0);
  })
})
