Rails.application.routes.draw do
  # Devise routes for login / signup / logout
  devise_for :users

  # Home page: show list of tickets
  root "tickets#index"

  # Ticket routes: /tickets, /tickets/:id, /tickets/new, etc.
  resources :tickets do
    # Comment route: /tickets/:ticket_id/comments (only create)
    resources :comments, only: [:create]
  end

  # Health check (default Rails)
  get "up" => "rails/health#show", as: :rails_health_check
end
