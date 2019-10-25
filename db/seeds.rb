# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

csv_text = File.read('./db/phone_codes.csv')
csv_text.gsub!('max len', 'max_len').gsub!('min len', 'min_len')
phone_codes = CSV.parse(csv_text, :headers => true)
phone_codes.each do |row|
  PhoneCode.create!(row.to_hash)
end
