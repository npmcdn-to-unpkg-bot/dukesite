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

  def image_url(obj)
    return obj.photo.image.url if image_exist?(obj)
  end

  def display_photo_image_tag(obj, alt=nil)
    img_url = image_url(obj)
    return image_tag img_url, alt: alt if img_url.present?
  end

  def link_to_display_article_image_tag(obj, alt=nil, link_path)
    link_to display_article_image(obj, alt=nil), link_path
  end

  def display_article_image(obj, alt=nil)
    img_url = obj.thumb_img_url
    if img_url.nil?
      # Use icon image if the article has no image
      icon = SiteConfig.find_by(slug: "icon")
      img_url = image_url(icon)
    end
    return image_tag img_url, alt: alt if img_url.present?
  end

  def text_truncate(obj, len)
    obj.truncate(len, :separator => " ",omission: '...')
  end

  def link_to_text_truncate(obj, len, link_path)
    link_to text_truncate(obj, len), link_path
  end
end
