class ContentsController < ApplicationController

    def index
        contents = Content.all
        render json: contents
    end
end
