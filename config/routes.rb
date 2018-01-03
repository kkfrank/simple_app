Rails.application.routes.draw do
  get 'static_pags/home'

  get 'static_pags/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#hello'

end
