class Api::PhoneCodeResource < JSONAPI::Resource
  attributes :prefix, :min_len, :max_len, :usage, :comment, :id

  filter :search, apply: ->(records, value, _options) {
    ::PhoneCodes::SearchQuery.call(value[0])
  }

  def self.records(options = {})
    PhoneCode.limit(10)
  end
end
