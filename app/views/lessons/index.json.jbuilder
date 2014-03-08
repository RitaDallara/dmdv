json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :title
  json.url lesson_url(lesson, format: :json)
end
