render_response(json, 200) do
  json.partial! partial: 'chat', chat: @chat
end
