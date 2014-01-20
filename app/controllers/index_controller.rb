class IndexController < ApplicationController
 before_filter :confirm_logged_in , :is_admin
  def index

  end


end
