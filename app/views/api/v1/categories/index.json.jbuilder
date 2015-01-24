json.array!(@categories) do |category|
  json.extract! category, :id, :name, :color, :created_at, :updated_at
  json.url      api_v1_category_url(category, format: :json)
end
