class DeviseOverrides::RegistrationsController < Devise::RegistrationsController
  # Respond to JSON format only
  clear_respond_to
  respond_to :json
end