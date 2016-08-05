class API < Grape::API
  format :json
  prefix 'api'
  version 'v1', using: :path

  resource :reviews do
    desc "List all review"
    get do
      Review.all
    end
  end
end
