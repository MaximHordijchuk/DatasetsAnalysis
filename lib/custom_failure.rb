class CustomFailure < Devise::FailureApp
  # Change redirect url for Devise. Sign in page by default
  def redirect_url
    root_url
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end