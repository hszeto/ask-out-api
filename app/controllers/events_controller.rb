class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    ap params
    ap current_user
  end
end