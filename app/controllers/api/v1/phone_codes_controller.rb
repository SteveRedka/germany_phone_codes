class Api::V1::PhoneCodesController < ApiController
  def meta(options)
    { total_pages: PhoneCode.count/20 }
  end
  def serialization_options
    {copyright: 'Copyright 2015'}
  end
  def subject
    'foo'
  end
  def self.links
    'baz'
  end
end
