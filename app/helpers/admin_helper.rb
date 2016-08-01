module AdminHelper
  def publish_status_btn(obj)
    obj.published? ? "btn-primary" : "btn-default"
  end

  def publish_status(obj)
    obj.published? ? "Published" : "Unpublished"
  end

  def publish_label(obj)
    obj.published? ? "label-success" : "label-default"
  end

  def published_thumb?(obj)
    'invisible_thumbnail' if !obj.published
  end

  def visibility_status_btn(obj)
    obj.visible? ? "btn-primary" : "btn-default"
  end

  def visibility_status(obj)
    obj.visible? ? "Visible" : "Hidden"
  end

  def visibility_label(obj)
    obj.visible? ? "label-success" : "label-default"
  end
end
