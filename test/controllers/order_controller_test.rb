require "test_helper"

class OrderControllerTest < ActionDispatch::IntegrationTest
  test "should get shipping" do
    get order_shipping_url
    assert_response :success
  end

  test "should get payment" do
    get order_payment_url
    assert_response :success
  end

  test "should get summary" do
    get order_summary_url
    assert_response :success
  end

  test "should get create" do
    get order_create_url
    assert_response :success
  end

  test "should get index" do
    get order_index_url
    assert_response :success
  end

  test "should get show" do
    get order_show_url
    assert_response :success
  end
end
