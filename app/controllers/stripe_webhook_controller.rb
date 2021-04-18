class StripeWebhookController < ApplicationController
  # require "sinatra"
  skip_before_action :verify_authenticity_token

  def listener
    # where we listen for stripes events

    # You can find your endpoint's secret in the output of the `stripe listen`
    # command you ran earlier
    endpoint_secret = "whsec_E0rGJogxXrlINPWgws9jVkSjEdSNKbej"

    event = nil

    # Verify webhook signature and extract the event
    # See https://stripe.com/docs/webhooks/signatures for more information.
    begin
      sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
      payload = request.body.read
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError
      # Invalid payload
      return head 400
    rescue Stripe::SignatureVerificationError
      # Invalid signature
      return head 400
    end

    if event["type"] == "checkout.session.completed"
      checkout_session = event["data"]["object"]

      fulfill_order(checkout_session)
    end

    head 200

    # Print out the event so you can look at it
    # puts "\n\n**********event**************\n\n"
    # puts event.inspect
    # puts "\n\n************************\n\n"

    # For now, you only need to print out the webhook payload so you can see
    # the structure.
    # puts "\n\n**********Payload**************\n\n"
    # puts payload.inspect
    # puts "\n\n************************\n\n"
  end

  def fulfill_order(checkout_session)
    # puts "Setting order to paid for #{checkout_session.inspect}"

    order = Order.find_by(stripe_session: checkout_session.id)
    # Check if the order is already paid (i think normally will be, but not sure)
    # if paid then mark order as paid otherwize mark as failed
    if checkout_session.payment_status == "paid"
      order.update(status: "paid")
    else
      order.update(status: "payment_failed")
    end
  end
end
