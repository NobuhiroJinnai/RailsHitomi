RailsTest::Application.routes.draw do
  get 'hello_rails/index'
  post 'hello_rails/update' => 'hello_rails#update'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
