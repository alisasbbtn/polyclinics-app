class PatientsController < ApplicationController
  load_and_authorize_resource

  def show
    @patient = Patient.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])

    if @patient.update(patient_params)
      redirect_to patient_path, notice: t('.success')
    else
      render action: 'edit'
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :patronymic, :gender, :birth_date, :photo)
  end
end
