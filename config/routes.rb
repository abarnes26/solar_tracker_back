Rails.application.routes.draw do
  root "welcome#index"

  namespace :api do
      namespace :v1 do
        resources "branches", only: [:create, :update, :index, :show, :destroy] do
          resources "projects", only: [:create, :update, :index, :show, :destroy]
          resources "vehicles", only: [:create, :update, :index, :show, :destroy]
          resources "pv_modules", only: [:create, :update, :index, :show, :destroy]
        end
    end
  end
end
