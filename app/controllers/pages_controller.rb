class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :tos, :privacy, :pricing ]

  def home
    @user = current_user
    @source = Source.new
  end

  def tos
  end

  def privacy
  end

  def pricing
  end
end
