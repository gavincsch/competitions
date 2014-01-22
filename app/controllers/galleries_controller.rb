class GalleriesController < ApplicationController
  before_filter :confirm_logged_in
  def index
    @galleries = Gallery.all
    @gallery = Gallery.new()
    @images = Image.all(params[:fk_gallery_id])
  end

  def show
    @gallery = Gallery.find(params[:id])
    @image = Image.new(params[@gallery.id])
    @images = Image.find_all_by_fk_gallery_id(@gallery.id)
  end

  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to gallery_path(@gallery), :notice => 'Album was successfully created.' }
      else
        format.html {redirect_to action: 'index', :notice => 'error.'}
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def update
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      if @album.save
        format.html { redirect_to gallery_url(@album), notice: 'Album was successfully updated.' }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def gallery_params
    params.require(:gallery).permit(:album_name)
  end
end
