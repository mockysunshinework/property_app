# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
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

# 管理者ユーザーを作成
admin_user = User.find_or_initialize_by(email: 'admin1@email.com')
password = ENV.fetch("ADMIN_PASSWORD") { raise '環境変数が設定されていません' }

admin_user.assign_attributes(
  password: password,
  password_confirmation: password,
  confirmed_at: Time.current,
  admin: true
)
admin_user.save!

# 物件を作成
(1..10).each { |i|
  address = ADDRESS_LISTS[i % ADDRESS_LISTS.size]
  station = STATION_LISTS[i % STATION_LISTS.size]
  property = Property.find_or_initialize_by(name: "サンプル物件#{i}")

  property.name = "サンプル物件#{i}"
  property.address = "#{address}#{i}-1"
  property.price = 30_000_000 + i * 1_000_000
  property.description = "詳細説明#{i}"
  property.minutes_by_walk = i * 2
  property.nearest_station = station
  property.save!

  property.images.purge

  image_paths = [
    Rails.root.join("db/seeds/properties/property_#{i}_1.jpg"),
    Rails.root.join("db/seeds/properties/property_#{i}_2.jpg"),
    Rails.root.join("db/seeds/properties/property_#{i}_3.jpg"),
    Rails.root.join("db/seeds/properties/property_#{i}_4.jpg")
  ]

  image_paths.each  { |image_path|
    next unless File.exist?(image_path)

    property.images.attach(
      io: File.open(image_path),
      filename: File.basename(image_path),
      content_type: "image/jpeg"
    )
  }
}
