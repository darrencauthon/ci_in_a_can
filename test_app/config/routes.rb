Rails.application.routes.draw do
  get  '/push' => 'github#push'
  post '/push' => 'github#push'
end
