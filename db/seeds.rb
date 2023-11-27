# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Event.delete_all

file = File.read('./db/seeds/fosdem-2023.json')
data = JSON.parse(file).deep_symbolize_keys

data[:events].each do |event|
  Event.create!(
    title: event[:title].strip,
    subtitle: event[:subtitle] || '',
    abstract: event[:abstract] || '',
    description: event[:description] || '',
    speakers: event[:persons]&.join(', ') || ''
  )
end
