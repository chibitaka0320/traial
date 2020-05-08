Rails.application.routes.draw do
  root 'tops#index'

  get "comments/:id" => "comments#show"
  post "comments/:post_id/create" => "comments#create"
  post "comments/:id/destroy" => "comments#destroy"

  post "likes/:post_id/create_post_show" => "likes#create_post_show"
  post "likes/:post_id/destroy_post_show" => "likes#destroy_post_show"
  post "likes/:post_id/create_index" => "likes#create_index"
  post "likes/:post_id/destroy_index" => "likes#destroy_index"
  post "likes/:post_id/create_user_show" => "likes#create_user_show"
  post "likes/:post_id/destroy_user_show" => "likes#destroy_user_show"

  get "users/index" => "users#index"
  get "signup" => "users#new"
  post "users/create" => "users#create"
  get "users/:id" => "users#show"
  get "users/:id/likes" => "users#likes"
  post "users/:id/destroy" => "users#destroy"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "users/:id/comment" => "users#comment"


  get 'posts/index'
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"
  post "posts/:id/destroy" => "posts#destroy"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  get "posts/:id/comment" => "posts#comment"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
