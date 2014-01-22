class ImagesController < ApplicationController
  before_filter :confirm_logged_in

  def show
    @image = Image.find_by_id(params[:id])
  end

  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to gallery_url(@image.fk_gallery_id), :notice => 'Image was successfully uploaded.' }
      else
        format.html {redirect_to gallery_path(@image.fk_gallery_id), :notice => 'error.'}
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end


  def image_params
    params.require(:image).permit(:images, :image_name, :fk_gallery_id)
  end

end
