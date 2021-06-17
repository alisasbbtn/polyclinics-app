class DoctorsController < ApplicationController
  load_and_authorize_resource except: :doctors_by_category

  def index
    if params.key?(:category_id)
      @doctors = params[:category_id].blank? ? Doctor.all : Doctor.where(category_id: params[:category_id])

      respond_to do |format|
        format.js { render layout: false }
      end
    else
      @doctor = Doctor.all

      respond_to do |format|
        format.html
      end
    end
  end

  def show
    @doctor = Doctor.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
end
