require "test_helper"
require "uri"

class UrlTest < ActiveSupport::TestCase
  def setup
    @url = urls(:five)
    url = URI.parse(@url.url_complete)
    @url_is_valid = url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  end

  test "url_complete should be valid" do
    assert @url_is_valid, "url_complete should be valid"
  end

  test "url_complete should not be invalid" do
    assert_not !@url_is_valid, "url_complete should not be invalid"
  end

  test "url_short should be less than or equal 5 characters" do
    assert @url.url_short.length <= 5, "url_short should be less than or equal 5 characters"
  end

  test "url_short should not be longer than 5 characters" do
    assert_not @url.url_short.length > 5, "url_short should not be longer than 5 characters"
  end

  test "url_short should not contain special characters" do
    assert_match(/\A[a-zA-Z0-9]+\z/, @url.url_short, "url_short should not contain special characters")
  end

  test "url_complete should not be duplicated" do
    @url_complete_duplicated = Url.exists?(url_complete: @url.url_complete)
    assert_not @url_complete_duplicated, "url_complete should not be duplicated"
  end

  test "url_short should not be duplicated" do
    @url_short_duplicated = Url.exists?(url_short: @url.url_short)
    assert_not @url_short_duplicated, "url_short should not be duplicated"
  end

end
