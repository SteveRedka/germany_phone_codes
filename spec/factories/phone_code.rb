FactoryBot.define do
  factory :phone_code do
    min_len { 3 }
    max_len { 3 }
    prefix { rand(99999) }
    comment { 'foobar' }
    usage { 'for testing' }
  end
end
