json.array!(@extras) do |extra|
  json.extract! extra, :id, :title
  json.url extra_url(extra, format: :json)
end
