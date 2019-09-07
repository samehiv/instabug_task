render_response(json, 200) do
  json.partial! partial: 'application', application: @application
end
