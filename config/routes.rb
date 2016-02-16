Ipdb::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post '/rate' => 'rater#create', :as => 'rate'

  devise_scope :user do
    get 'users/select_plan', to: 'users/registrations#select_plan', as: 'select_plan'
    get 'users/select_silver', to: 'users/registrations#select_silver', as: 'select_silver'
    post 'users/finish', to: 'users/registrations#finish', as: 'finish'
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "omniauth_callbacks"
  }

  mount Commontator::Engine => '/commontator'

  root "pages#home"
  get "dashboard" => "pages#dashboard"
  get "about" => "pages#about"
  get "privacy" => "pages#privacy"
  get "media" => "pages#media"
  get "terms" => "pages#terms"
  get "ppff" => "pages#ppff"
  get "faq" => "pages#faq"
  get "pricing" => "pages#pricing"

  resources :user, :path => "users" do
    get :autocomplete_user_username, :on => :collection
  end

  resources :podcasts do
    get :autocomplete_podcast_name, :on => :collection

    resources :people_podcasts, :path => :connections, only: [:new, :create]
    member do
      get :follow
      get :unfollow
      get :ppff
      put "like", to: "podcasts#upvote"
      post :count
    end
  end
  resources :people do
    get :autocomplete_person_name, :on => :collection
    post :search, :on => :collection
  end
  resources :companies do
    resources :companies_people, only: [:new, :create]
    resources :companies_podcasts, :path => :connections, only: [:new, :create]
  end

  #profile
  get 'profile/overview',  to: 'profile#overview'
  get 'profile/podcasts',  to: 'profile#podcasts'
  get 'profile/companies', to: 'profile#companies'
  get 'profile/messages',  to: 'profile#messages'
  get    'profile/messages/incomings/:id', to: 'incomings#show', as: 'incoming'
  delete 'profile/messages/incomings/:id', to: 'incomings#destroy'
  delete 'incomings/delete_bunch', to: 'incomings#delete_bunch'
  get 'profile/messages/sent/:id', to: 'messages#show', as: 'sent'

  resources :messages, only: :create

end