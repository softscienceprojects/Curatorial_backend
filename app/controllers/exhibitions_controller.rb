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
            render json: { errors: exhibition.errors.full_messages }, status: :not_acceptable
        end
    end

    def update
        exhibition = Exhibition.find(params[:id])
        exhibition.update(exhibition_params)
        if (exhibition.valid?)
            render json: exhibition
        else
            render json: { errors: exhibition.errors.full_messages, id: exhibition.id }, status: :not_acceptable
        end
    end

    def destroy
        exhibition = Exhibition.find(params[:id])
        exhibition.destroy
        render json: exhibition
    end

    private

    def exhibition_params
        params.require(:exhibition).permit(:user_id, :title, :summary, :description, :public, :photo)
    end
end
