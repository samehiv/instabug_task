render_response(json, 200) do
  json.items do
    json.array! @data.items, partial: 'application', as: :application
  end

  json.pagination @data.pagination
end
