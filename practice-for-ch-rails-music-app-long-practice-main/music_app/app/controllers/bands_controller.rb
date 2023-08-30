class BandsController < ApplicationController
    before_action :set_band, only: [:show, :edit, :update, :destroy]

    def index
        @bands = Band.all  
        render :index
    end
    
    def create
        @band = Band.new(band_params)
    
        if @band.save
          redirect_to bands_url
        else
          # render json: @user.errors.full_messages, status: 422
          flash.now[:errors] = @band.errors.full_messages 
          render :new
        end
    end
    
    
    def update
        set_band
        if @band.update(band_params)
            redirect_to band_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :edit
        end
    end
    
    def destroy
        set_band
        @band.destroy
        redirect_to bands_url
    end
    
    def edit
        set_band
        render :edit
    end

    def show 
        set_band
        render :show
    end

    def set_band
        @band = Band.find_by(id: params[:id])
    end

    private
    def band_params
        params.require(:band).permit(:name)
    end

    
end
