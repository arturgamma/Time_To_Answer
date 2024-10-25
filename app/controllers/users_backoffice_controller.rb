class UsersBackofficeController < ApplicationController
  before_action :authenticate_user!
  layout 'Users_BACKOFFICE'
end
