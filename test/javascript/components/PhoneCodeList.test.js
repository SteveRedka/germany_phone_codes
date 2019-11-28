import React from 'react'
import {mount, shallow} from 'enzyme'
import PhoneCodeList from 'components/PhoneCodeList.js'

const wrapper = mount(<PhoneCodeList />); // mount/render/shallow when applicable

expect(wrapper.find('#checked')).toBeChecked();
