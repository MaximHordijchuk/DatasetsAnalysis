class DeviseOverrides::SessionsController < Devise::SessionsController
  # Respond to JSON format only
  clear_respond_to
  respond_to :json
end