class UsersController < ApplicationController
    def index
        render json: User.all
    end

    def show
        render json: User.find(params[:id])
    end

    def new
        user = User.new
    end

    def create
        user = User.create(user_params)
        render json: user
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :biography, :public, :photo)
    end
end
