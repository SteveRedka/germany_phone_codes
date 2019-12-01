FactoryBot.define do
  factory :phone_code do
    min_len { 3 }
    max_len { 3 }
    prefix { rand(99999) }
    comment { FFaker::AddressDE.unique.city }
    usage { FFaker::Lorem.phrase }
  end
end
