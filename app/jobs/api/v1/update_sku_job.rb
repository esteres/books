class Api::V1::UpdateSkuJob < ApplicationJob
  queue_as :default

  def perform(book_name)
    uri = URI('http://localhost:4567/update_sku')
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = { sku: '123', name: book_name }.to_json
    res = Net::HTTP.start(uri.host_name, uri.port) do |http|
      http.request(req)
    end
  end
end
