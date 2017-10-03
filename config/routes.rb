Rails.application.routes.draw do
  
  # get 'pages/index'
  get 'about', to: 'pages#about'
  
  root 'pages#about'
  
  resources :articles
  
  get 'signup', to: 'users#new'
  resources :users, except: [:new]  
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :categories, except: [:destroy]
  
  resources :horarios do
    collection do
      post :validar_horario
      get :validar
      get :meus_horarios
    end
  end
  
  resources :funcionarios do
    collection do
      get ':id/horarios', to: 'funcionarios#horarios'
    end
  end
  
  #resources :funcionarios do
    #resources :horarios
  #end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
