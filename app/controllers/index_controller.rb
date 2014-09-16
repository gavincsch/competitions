class IndexController < ApplicationController
 before_filter :confirm_logged_in
  def index
    @users = User.all
  end


end
