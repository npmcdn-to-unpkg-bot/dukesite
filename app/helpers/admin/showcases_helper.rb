module Admin::ShowcasesHelper
  def display_on_landing_page?(showcase)
    if showcase.show_on_landing_page?
      content_tag :small do
        content_tag :span, "Landing Page", class: ["label", "label-success", "pull-right"]
      end
    end
  end
end
