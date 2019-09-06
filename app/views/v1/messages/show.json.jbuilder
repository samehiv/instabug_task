render_response(json, 200) do
  json.partial! partial: 'message', message: @message
end
