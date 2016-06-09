module Admin
  class AdminController < ApplicationController
    layout "admin/application"

    before_filter :check_admin_permission

    private

    def check_admin_permission
      authorize! :access, :admin
    end
  end
end
