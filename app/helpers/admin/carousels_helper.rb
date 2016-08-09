module Admin::CarouselsHelper
  def invisible_thumb?(obj)
    'invisible_thumbnail' if !obj.visible
  end
end
