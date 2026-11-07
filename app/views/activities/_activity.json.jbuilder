json.extract! activity, :id, :title, :category, :duration, :date, :notes, :created_at, :updated_at
json.url activity_url(activity, format: :json)
