class Admin::ShowcasesController < AdminController
  def index
    @showcases = Showcase.all
  end
end
