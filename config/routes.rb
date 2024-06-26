Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :quotes do
    resources :line_item_dates, except: [:index, :show]
  end
end
