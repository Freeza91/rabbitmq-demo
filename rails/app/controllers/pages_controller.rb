class PagesController < ApplicationController

  def home
    p Publish.publish('logs', 'hello logs queue')
  end

end