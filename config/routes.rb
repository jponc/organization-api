Rails.application.routes.draw do
  namespace :api do
    get '/locations/:group_organization_id' => 'locations#show'
    post '/model_type_prices/:group_organization_id' => 'model_type_prices#show'
  end
end
