module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def collapse_class(*link_paths)
    collapse_status = false
    link_paths.each { |link_path| collapse_status ||= current_page?(link_path) }    
    collapse_status ? 'in' : nil
  end

  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end
end
