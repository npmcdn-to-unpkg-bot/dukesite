module AdminHelper
  def publish_status_btn(obj)
    obj.published? ? "btn-primary" : "btn-default"
  end

  def visible_status_btn(obj)
    obj.visible? ? "btn-primary" : "btn-default"
  end

  def visibility_status(obj)
    obj.visible? ? "Visible" : "Hidden"
  end

  def visibility_label(obj)
    obj.visible? ? "label-success" : "label-default"
  end
end
