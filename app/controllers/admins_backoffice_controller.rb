class AdminsBackofficeController < ApplicationController
  before_action :authenticate_admin!
  layout 'Admins_BACKOFFICE'
end
