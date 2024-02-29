require "test_helper"

class UrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url = urls(:one)
  end

  test "should get new" do
    get new_url_url
    assert_response :success
  end

  test "should show url" do
    get url_url(@url)
    assert_response :success
  end

end
