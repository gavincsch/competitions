Blair::Application.routes.draw do


  resources :competitions
  get   'competitions/:campaign/entries',   :to => 'competitions#entries'
  get   'competitions/:campaign',           :to => 'competitions#show'
  get   'competitions/:campaign/thankyou',  :to => 'competitions#thankyou', :as => 'thankyou'
  post  'competitions/:campaign/entry',     :to => 'competitions#create_entry'
  resources :galleries
  resources :images
  resources :index
  get 'users/sign_in' => 'users#sign_in'
  resources :users

  root :to => "index#index"
  post "sessions/new"
  get "sessions/destroy"

end
