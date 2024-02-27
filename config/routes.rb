Rails.application.routes.draw do
  resources :urls
  root "urls#new"
  get '/:url_short', to: 'urls#redirect', as: 'redirect_url'
  get '/urls/show', to: 'urls#show', defaults: { format: :json }
end
