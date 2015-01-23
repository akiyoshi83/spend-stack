json.array!(@trades) do |trade|
  json.extract! trade, :id, :amount, :trade_at, :memo, :created_at, :updated_at
  json.category trade.category
  json.tags     trade.tags
  json.url      api_v1_trade_url(trade, format: :json)
end
