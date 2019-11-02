class ExhibitionsController < ApplicationController
    def index
        render json: Exhibition.all
    end

    def show
        render json: Exhibition.find(params[:id])
    end

    def new
        exhibition = User.new
    end

    def create
        exhibition = Exhibition.create(exhibition_params)
        if (exhibition.valid?)
            render json: exhibition
        else
            render json: exhibition.errors.full_messages
        end
    end

    def update
        exhibition = Exhibition.find(params[:id])
        exhibition.update(exhibition_params)
        render json: exhibition
    end

    def destroy
        exhibition = Exhibition.find(params[:id])
        exhibition.destroy
    end

    private

    def exhibition_params
        params.require(:exhibition).permit(:user_id, :title, :summary, :description, :public, :photo)
    end
end
