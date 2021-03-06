Rails.application.routes.draw do
  root to: 'pages#home'
  #originally devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' } # now we need to tell devise (extend) that when devise is about to register a user we need to know if pro or basic. we do this with a new controller called registrations
  get 'about', to: 'pages#about'
  resources :contacts, only: [:create]
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
