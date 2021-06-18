class DoctorsController < ApplicationController
  load_and_authorize_resource

  def index
    if params.key?(:category_id)
      doctors_by_category
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

  private

  def doctors_by_category
    @doctors = params[:category_id].blank? ? Doctor.all : Doctor.where(category_id: params[:category_id])

    respond_to do |format|
      format.js { render layout: false }
    end
  end
end

