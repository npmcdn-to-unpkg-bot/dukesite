class Admin::PhotosController < AdminController
  def index
    @photos = Photo.all.order("updated_at DESC")
  end
end