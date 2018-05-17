Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # resources :questions 
  get 'questions/print', :to => 'questions#print'
  resources :teachers 

end
