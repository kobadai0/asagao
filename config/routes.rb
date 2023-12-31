Rails.application.routes.draw do
   root "top#index"
   get "about" => "top#about", as: "about"

   1.upto(18) do |n|
      get "lesson/step#{n}(/:name)" => "lesson#step#{n}"
   end

   resources :members, only: [:index, :show] do
      get "search", on: :collection # 検索用
      resources :entries, only: [:index]
   end

   resource :session, only: [:create, :destroy]
   resource :account, only: [:show, :edit, :update]
   resource :password, only: [:show, :edit, :update]

   resources :articles, only: [:index, :show]
   resources :entries do
      patch "like", "unlike", on: :member
      get "voted", on: :collection
      resources :images, controller: "entry_images" do
         patch :move_higher, :move_lower, on: :member
      end
   end
   
   namespace :admin do
      root "top#index"
      resources :members do
         get "search", on: :collection
      end
      resources :articles
   end
end