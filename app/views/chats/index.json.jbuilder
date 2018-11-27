json.array! @newest_chats.all do |chat|
  json.id chat.id
  json.user_name chat.user.name
  json.updated_at chat.updated_at
  json.text chat.text
  json.image_tag chat.image
end
