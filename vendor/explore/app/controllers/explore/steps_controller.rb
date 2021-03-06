module Explore
  class StepsController < ApplicationController
    layout 'explore/reading', :only => [:flow]

    def index
    end

    def flow
      @tutorial = Explore::Mock.tutorials.select {|x| x.id.to_s == params[:tutorial_id]}.first

      return if @tutorial.newtype

      id = 0
      steps = @tutorial.steps.map {|x|
        id = id + 1
        {
          :id => id,
          :continue => {
            :id => id + 1
          },
          :data => {
            :title => x.title,
            :blocks => x.blocks
          }
        }
      }

      @tutorial.steps = Explore::JSONStruct.open(steps.to_json)
      @tutorial.steps.last.continue = 'end'

      # render :json => @tutorial.steps.last
    end

    def show
    end

    def finish
    end
  end
end