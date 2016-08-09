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

  def create_time(obj)
    obj.created_at.nil? ? 'Not Saved Yet' : obj.created_at.to_formatted_s(:long)
  end

  def update_time(obj)
    if obj.created_at.nil?
      'Not Saved Yet'
    else
      create_time = obj.created_at
      update_time = obj.updated_at
      obj.updated_at.nil? ? time = create_time : time = update_time
      time.to_formatted_s(:long)
    end
  end
end
