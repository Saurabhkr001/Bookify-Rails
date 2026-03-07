require "stripe"

Stripe.api_key = ENV.fetch("STRIPE_SECRET_KEY")
Stripe.api_key