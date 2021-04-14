Rails.configuration.stripe = {
  publishable_key: ENV["PUBLISHABLE_KEY"],
  secret_key:      ENV["SECRET_KEY"]
}
# E NV[] hash allows us to access the OS environment variables!
Stripe.api_key = Rails.configuration.stripe[:sevret_key]
