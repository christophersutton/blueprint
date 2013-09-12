json.array!(@cards) do |card|
  json.extract! card, :title, :description, :type, :position
  json.url card_url(card, format: :json)
end
