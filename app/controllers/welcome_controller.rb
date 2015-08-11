class WelcomeController < ApplicationController
  def index
    User.using.do_work
  end
end
