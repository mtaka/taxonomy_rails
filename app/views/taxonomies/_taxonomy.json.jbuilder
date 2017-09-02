json.extract! taxonomy, :id, :name, :key, :version, :owner, :description, :notes, :body, :created_at, :updated_at
json.url taxonomy_url(taxonomy, format: :json)
