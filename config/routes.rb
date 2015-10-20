Ipdb::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post '/rate' => 'rater#create', :as => 'rate'

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  mount Commontator::Engine => '/commontator'

  root "pages#home"
  get "dashboard" => "pages#dashboard"
  get "about" => "pages#about"
  get "awards" => "pages#awards"
  get "profile" => "pages#profile"
  get "privacy" => "pages#privacy"
  get "media" => "pages#media"
  get "terms" => "pages#terms"
  get "ppff" => "pages#ppff"
  get "faq" => "pages#faq"

  resources :user, :path => "users" do
    get :autocomplete_user_username, :on => :collection
  end

  resources :people_podcasts, :path => :connections, only: [:new, :create]

  resources :podcasts do
    get :autocomplete_podcast_name, :on => :collection
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
  end
end