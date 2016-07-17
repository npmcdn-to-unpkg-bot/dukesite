module AdminHelper
  def publish_status_btn(obj)
    obj.published? ? "btn-primary" : "btn-default"
  end

  def visible_status_btn(obj)
    obj.visible? ? "btn-primary" : "btn-default"
  end

  def display_photo_image_tag(obj)
    if !obj.photo.nil? && obj.photo.image.thumb.url.present?
      img_url = obj.photo.image.url
    else
      img_url = "http://thedudeminds.de/images/no_image_available.png"
    end
    return image_tag img_url
  end

  def visibility_status(obj)
    obj.visible? ? "Visible" : "Hidden"
  end

  def visibility_label(obj)
    obj.visible? ? "label-success" : "label-default"
  end
end