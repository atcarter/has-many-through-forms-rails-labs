class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories, reject_if: proc { |attributes| attributes["name"] == ""}

  #need to modify the default categories_attributes method so that we don't duplicate categories
  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      # if category.name != ""
      self.categories << category unless category.name.empty?
      # end
    end
  end

end
