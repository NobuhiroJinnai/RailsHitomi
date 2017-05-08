RailsTest::Application.routes.draw do
  get 'hello_rails/index'
  get 'hello_rails/setting'
  post 'hello_rails/update' => 'hello_rails#update'
  post 'hello_rails/new_user'=>'hello_rails#new_user'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
