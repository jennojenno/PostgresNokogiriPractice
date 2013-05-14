require 'machinist/active_record'

Article.blueprint do
	title { "Cool story bro" }
	body { "Body of the story for the coolbros!" }
end
User.blueprint do
  # Attributes here
end
