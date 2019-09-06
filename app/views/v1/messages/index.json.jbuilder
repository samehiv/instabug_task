render_response(json, 200) do
  json.items do
    json.array! @data.items, partial: 'message', as: :message
  end

  json.pagination @data.pagination
end
