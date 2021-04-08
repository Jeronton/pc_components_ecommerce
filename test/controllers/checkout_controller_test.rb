require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get shipping" do
    get checkout_shipping_url
    assert_response :success
  end

  test "should get payment" do
    get checkout_payment_url
    assert_response :success
  end
end
