# 2017.09.02 Switched to API mode
# https://railsguides.jp/api_app.html
#class ApplicationController < ActionController::Base
class ApplicationController < ActionController::API
  #protect_from_forgery with: :exception
end
