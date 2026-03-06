# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Property.delete_all
ADDRESS_LISTS = [
  '東京都渋谷区渋谷',
  '東京都世田谷区世田谷',
  '東京都目黒区目黒'
].freeze

STATION_LISTS = [
  '渋谷',
  '下北沢',
  '目黒'
].freeze

(1..100).each { |i|
  address = ADDRESS_LISTS[i % ADDRESS_LISTS.size]
  station = STATION_LISTS[i % STATION_LISTS.size]

  Property.find_or_create_by!(
    name: "サンプル物件#{i}",
    address: "#{address}#{i}-1",
    price: 30_000_000 + i * 1_000_000,
    description: "詳細説明#{i}",
    minutes_by_walk: i * 2,
    nearest_station: station
  )
}
