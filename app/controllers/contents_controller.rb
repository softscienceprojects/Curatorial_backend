class ContentsController < ApplicationController

    def index
        contents = Content.all
        render json: contents
    end

    def search
        content = Content.find_by(description: params[:description])
        if content 
            render json: {content: ContentSerializer.new(content)}
        else
            render json: {errors: ["Nothing matches"]}, status: :not_found
        end
    end

    private
    
    def content_params
        params.require(:content).permit(:description)
    end

end
