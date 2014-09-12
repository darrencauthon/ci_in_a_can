require 'sidekiq/web'
Rails.application.routes.draw do
  get  '/push' => 'github#push'
  post '/push' => 'github#push'
  mount Sidekiq::Web => 'sidekiq'
end
