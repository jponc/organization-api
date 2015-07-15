Rails.application.routes.draw do
  namespace :api do
    get '/locations/:group_organization_id' => 'locations#show'
  end
end
