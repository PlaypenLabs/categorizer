module CategoriesHelper
  def can_delete_category?(category)
    category.reports.present?
  end
end
