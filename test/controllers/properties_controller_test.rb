require "test_helper"

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get properties_path
    assert_response :success
  end
end
