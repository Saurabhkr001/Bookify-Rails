class PaymentsController < ApplicationController

def create
  Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

  amount = params[:amount].to_f

  session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
    line_items: [{
      price_data: {
        currency: 'inr',
        product_data: {
          name: "Books Cart Purchase"
        },
        unit_amount: (amount * 100).to_i
      },
      quantity: 1
    }],
    mode: 'payment',
    success_url: success_url,
    cancel_url: cancel_url
  )

  redirect_to session.url, allow_other_host: true
end

  def success
    flash[:notice] = "Payment Successful!"
  end

  def cancel
    flash[:alert] = "Payment Cancelled!"
  end

end