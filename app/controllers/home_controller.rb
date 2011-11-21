class HomeController < ApplicationController
  before_filter :check_signed_in

  def index

  end

  private

  def check_signed_in
    redirect_to ideas_path     if user_signed_in?
  end
end