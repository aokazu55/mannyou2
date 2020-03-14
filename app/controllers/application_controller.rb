class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => ENV['USER'], :password_digest => ENV['PASS'] if Rails.env == "production"
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper
  include LabelsHelper
end
