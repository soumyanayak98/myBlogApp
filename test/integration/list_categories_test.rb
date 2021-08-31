require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(:name =>"Sports")
    @category2 = Category.create(:name =>"Travels")
  end

  test "should show categories list" do
    get "/categories"
    assert_select "a[href=?]", category_path(@category), @category.name
    assert_select "a[href=?]", category_path(@category2), @category2.name
  end
end
