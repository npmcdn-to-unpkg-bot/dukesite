module Admin::CategoriesHelper
  def existed?(obj)
    obj.id.present? ? true : false
  end
end