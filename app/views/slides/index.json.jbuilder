json.array!(@slides) do |slide|
  json.extract! slide, :id, :title, :content, :previous, :next, :number
  json.url slide_url(slide, format: :json)
end
