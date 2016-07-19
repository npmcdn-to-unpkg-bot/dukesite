module WelcomeHelper
  def active_carousel?(carousel, visible_carousels)
    return "active" if carousel.id == visible_carousels.first.id
  end

  def display_carousel_indicator(i , num)
    target = "#carousel-example-generic"
    slide_to = i
    status = "active" if i == 0
    content_tag :li, nil, :data=> {target: target, 'slide-to' => slide_to}, class: status
  end

  def display_photo_image_tag(obj, alt = nil)
    img_url = image_url(obj)
    return image_tag img_url, alt: alt
  end

  def image_url(obj)
    return obj.photo.image.url if image_exist?(obj)
  end

  def display_showcase_carousels(obj)
    # First item must be "active"
    groups = obj.published_products[0..11].in_groups_of(4, false)
    first_group = groups.first

    groups.collect do |group|
      status = "item"
      status << " active" if group == first_group
      content_tag :div, class: status do
        sanitize render_products(group)
      end
    end.join
  end

  def render_products(array)
    array.collect do |p|
      render partial: "product_thumbnail", locals: { p: p }
    end.join
  end
end
