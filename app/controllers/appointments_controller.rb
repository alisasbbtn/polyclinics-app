class AppointmentsController < ApplicationController
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |_exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html(redirect_to(if current_doctor
                                main_app.root_url
                              else
                                new_patient_session_path
                              end, notice: t('unauthorized.manage.appointments')))
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end

  def index
    if params.key?(:doctor_id)
      @doctor = Doctor.find(params[:doctor_id])
      # Show patient all their appointments with selected doctor or all doctor's appointments
      @appointments = current_patient ? @doctor.appointments.where(patient_id: current_patient.id) : @doctor.appointments
    else
      @patient = Patient.find(params[:doctor_id])
      # Show doctor all their appointments with selected patient or all patient's appointments
      @appointments = current_doctor ? @patient.appointments.where(doctor_id: current_doctor.id) : @patient.appointments
    end
  end

  def new
    @doctor = Doctor.find(params[:doctor_id])
    @appointment = @doctor.appointments.new(patient_id: current_patient.id)

    respond_to do |format|
      format.html
    end
  end

  def get_available_hours
    @doctor = Doctor.find(params[:doctor_id])

    date = DateTime.strptime(params[:date], '%Y-%m-%d')

    busy_hours = @doctor.appointments.active.where(datetime: date.all_day).collect { |d| d.datetime.hour }
    working_hours = (9..18)
    @available_hours = working_hours - busy_hours

    respond_to do |format|
      format.js { render layout: false }
    end
  end
end
