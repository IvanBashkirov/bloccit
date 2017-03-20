Rails.application.routes.draw do

  resources :advertisements

  resources :posts

  get 'about' => 'welcome#about'

  get 'faq' => 'welcome#faq'

  get 'about' => 'welcome#index'

  root 'welcome#index'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
