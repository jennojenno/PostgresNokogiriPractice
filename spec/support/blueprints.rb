require 'machinist/active_record'

Article.blueprint do
	title { Faker::Lorem.words(3).join(" ") }
	body { Faker::Lorem.words(30).join(" ") }
end

User.blueprint do
  # Attributes here
  email {Faker::Internet.email}
  password {'password'}
  password_confirmation {'password'}
end

Track.blueprint do
  # Attributes here
end
