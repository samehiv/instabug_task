render_response(json, 200) do
  json.items do
    json.array! @data.items, partial: 'chat', as: :chat
  end

  json.pagination @data.pagination
end
