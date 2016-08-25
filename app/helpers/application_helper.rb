module ApplicationHelper
  def active_class(*link_paths)
    active_status = false
    link_paths.each { |link_path| active_status ||= current_page?(link_path) }    
    active_status ? 'active' : nil
  end

  def collapse_class(*link_paths)
    collapse_status = false
    link_paths.each { |link_path| collapse_status ||= current_page?(link_path) }    
    collapse_status ? 'in' : nil
  end

  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end

  def image_exist?(obj)
    (!obj.photo.nil? && obj.photo.image.url.present?) ? true : false
  end

  def image_url(obj, options={:thumb => nil})
    if image_exist?(obj)
      options[:thumb].nil? ? obj.photo.image.url : obj.photo.image.thumb.url
    end
  end

  def display_photo_image_tag(obj, options = {})
    img_url = image_url(obj, options)
    return image_tag img_url if img_url.present?
  end

  def link_to_display_article_image_tag(obj, link_path, options = {})
    link_to display_article_image(obj, options), link_path
  end

  def display_article_image(obj, options={})
    img_url = obj.thumb_img_url
    # Use icon image if the article has no image
    if img_url.nil?
      icon = SiteConfig.find_by(slug: "icon")
      img_url = image_url(icon, options)
    end
    return image_tag img_url
  end

  def flash_class(key)
    case key
    when "success"
      "alert alert-success alert-dismissible"
    when "error"
      "alert alert-danger alert-dismissible"
    when "alert"
      "alert alert-warning alert-dismissible"
    else "notice"
      "alert alert-info alert-dismissible"
    end
  end
end
