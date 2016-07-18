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

end