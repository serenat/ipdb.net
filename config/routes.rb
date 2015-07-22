Ipdb::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
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
  resources :user_podcasts, :path => "connections"
  resources :podcasts do
    get :autocomplete_podcast_name, :on => :collection
      member do
        get :follow
        get :unfollow
        get :ppff
        put "like", to: "podcasts#upvote"
      end
    end
end