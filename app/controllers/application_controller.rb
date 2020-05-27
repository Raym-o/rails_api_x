# Modified from ::Api to ::Base to allow ActiveAdmin with Api
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
