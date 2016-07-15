module AdminHelper
  def publish_status_btn(p)
    p.published? ? "btn-primary" : "btn-default"
  end

  def visible_status_btn(p)
    p.visible? ? "btn-primary" : "btn-default"
  end
end