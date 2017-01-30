json.extract! sitio, :id, :titulo, :direccion, :notas, :latitude, :longitude, :created_at, :updated_at
json.url sitio_url(sitio, format: :json)