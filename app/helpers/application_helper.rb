module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def collapse_class(link_path)
    current_page?(link_path) ? "in" : ""
  end
end
