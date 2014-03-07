class Admin::AdminController < ApplicationController

  http_basic_authenticate_with name: ENV["ADMIN_LOGIN"], password: ENV["ADMIN_PASSWORD"]
  layout 'layouts/admin/application'

  def dashboard
  end

end