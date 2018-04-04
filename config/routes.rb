Rails.application.routes.draw do
  root "welcome#index"

  namespace :api do
      namespace :v1 do
        resources "branches"
        resources "projects"
        resources "vehicles"
    end
  end
end
