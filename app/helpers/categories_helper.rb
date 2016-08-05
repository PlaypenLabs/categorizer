module CategoriesHelper
  def can_delete_category?(category)
    category.reports.blank?
  end
end
