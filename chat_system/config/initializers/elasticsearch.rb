Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: Rails.application.credentials[Rails.env.to_sym][:elasticsearch_host] )




