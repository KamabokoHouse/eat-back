Rails.application.routes.draw do
    get '/restaurant', to: 'restaurants#show'
end
