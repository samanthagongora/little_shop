class AdminController < ApplicationController
  before_action :check_admin

  def show
    @user = current_user
    @orders = Order.all
  end

  private

  def check_admin
    render file: 'public/404' unless current_admin
  end
 end
