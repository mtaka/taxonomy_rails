json.extract! page_re, :id, :url, :owner, :description, :created_at, :updated_at
json.url page_re_url(page_re, format: :json)
