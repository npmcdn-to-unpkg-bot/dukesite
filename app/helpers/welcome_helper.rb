module WelcomeHelper
  def active_carousel?(carousel, visible_carousels)
    return "active" if carousel.id == visible_carousels.first.id
  end

  def carousel_bg_image(obj)
    if image_url(obj) != nil
      image_url = "(" + image_url(obj) + ")"
      cover = " center no-repeat; background-size:cover"
      bg_url = "background:url"
      return bg_url + image_url + cover
    end
  end

  def display_carousel_collection(carousel, visible_carousels)
    carousel_class = ["item ", active_carousel?(carousel, visible_carousels)]
    carousel_style = carousel_bg_image(carousel)
    # content_tag :div, nil, class: carousel_class, style: carousel_style do
    content_tag :div, nil, class: carousel_class do
      content_tag :div, nil, class: "item-inner", style: carousel_style do
        display_carousel_caption(carousel, "carousel-caption")
      end
    end
  end

  def display_carousel_indicator(i , num)
    target = "#carousel-example-generic"
    slide_to = i
    status = "active" if i == 0
    content_tag :li, nil, :data=> {target: target, 'slide-to' => slide_to}, class: status
  end

  def display_carousel_caption(carousel, class_name)
    title = content_tag :h3, carousel.title
    desc = content_tag :h4, carousel.description, class: "hidden-xs"
    link = carousel.url
    btn = link_to "More", link, class: "btn-carousel"
    content = title
    content = title + desc if carousel.description.present?
    content = content + btn if carousel.url.present?
    content_tag :div, class: class_name do
      content
    end
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

  def showcase_title_carousel(showcase)
    showcase.title.gsub(/\s+/, '') + "Carousel"
  end
end
