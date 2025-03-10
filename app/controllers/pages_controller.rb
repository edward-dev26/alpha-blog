class PagesController < ApplicationController
  def home
    redirect_to articles_path if is_auth
  end

  def about
  end
end
