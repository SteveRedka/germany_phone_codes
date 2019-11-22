class Api::PhoneCodeResource < JSONAPI::Resource
  attributes :prefix, :min_len, :max_len, :usage, :comment, :id
end
