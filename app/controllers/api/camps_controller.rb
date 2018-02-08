class Api::CampsController < ApplicationController
  before_action :set_camp, except: [:index, :create]

  def index
    render json: Camp.all
  end

  def show
    render json: @camp
  end

  def create
    camp = Camp.new(camp_params)
    if camp.save
      render json: camp
    else
      render json: json_error(camp)
    end
  end

  def update
    if @camp.update(camp_params)
      render json: @camp
    else
      json_error(@camp)
    end
  end

  def destroy
    @camp.destroy
  end

  private
    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(
        :name, :year_founded, :active,
        :languages, :full_time_tuition_cost,
        :part_time_tuition_cost
      )
    end
end
