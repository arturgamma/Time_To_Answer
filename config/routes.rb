Rails.application.routes.draw do
   namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    post 'answer', to: 'answer#question'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index' #Dashboard
    #get 'admins/index'
    #get'admins/edit/:id', to: 'admins#edit'
    resources :admins   #,  except: [:destroy] #administradores
    resources :subjects #assuntos/Áreas
    resources :questions #Perguntas
  end
  devise_for :admins
  devise_for :users
  get 'inicio', to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'site/welcome#index'
end
