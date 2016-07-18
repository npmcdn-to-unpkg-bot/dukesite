module AdminHelper
  def publish_status_btn(obj)
    obj.published? ? "btn-primary" : "btn-default"
  end

  def visible_status_btn(obj)
    obj.visible? ? "btn-primary" : "btn-default"
  end

  def display_photo_image_tag(obj)
    img_url = image_url(obj)
    return image_tag img_url
  end

  def image_url(obj)
    if image_exist?(obj)
      return obj.photo.image.url
    else
      return "http://thedudeminds.de/images/no_image_available.png"
    end
  end

  def visibility_status(obj)
    obj.visible? ? "Visible" : "Hidden"
  end

  def visibility_label(obj)
    obj.visible? ? "label-success" : "label-default"
  end

  def image_exist?(obj)
    (!obj.photo.nil? && obj.photo.image.url.present?) ? true : false
  end
end
