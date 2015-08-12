class WelcomeController < ApplicationController
  def index
    User.do_work
  end
end
