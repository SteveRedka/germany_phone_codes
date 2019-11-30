class Api::V1::PhoneCodeResource < JSONAPI::Resource
  attributes :prefix, :min_len, :max_len, :usage, :comment, :id

  filter :search, apply: ->(records, value, _options) {
    ::PhoneCodes::SearchQuery.call(value[0])
  }

  def self.records(options = {})
    PhoneCode # .limit(20)
  end

  def self.meta(options)
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
