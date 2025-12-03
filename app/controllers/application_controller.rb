class ApplicationController < ActionController::Base
  # Disable CSRF authenticity check in development (Codespaces issue)
  skip_forgery_protection if: -> { Rails.env.development? }

  # Only allow modern browsers
  allow_browser versions: :modern

  # Auto-refresh when importmap changes
  stale_when_importmap_changes
end
