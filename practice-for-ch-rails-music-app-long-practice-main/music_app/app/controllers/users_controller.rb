class UsersController < ApplicationController
    before_action :require_logged_in, only: [:show, :destroy]
    before_action :require_logged_out, only: [:new, :create]

    def new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login!(@user)
            redirect_to user_url(@user.id)
        else
            render json: @user.errors.full_messages, status: 422
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
