class AppointmentsController < ApplicationController
  load_and_authorize_resource except: :index

  before_action :fix_params, only: :create

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        redirect_to (current_doctor ? main_app.root_url : new_patient_session_path),
                    notice: t('unauthorized.manage.appointments')
      end
    end
  end

  def index
    params.key?(:doctor_id) ? appointments_for_doctor : appointments_for_patient

    @appointments = @appointments.page(params[:page])

    respond_to do |format|
      format.html
    end
  end

  def show
    @doctor = Doctor.find(params[:doctor_id])
    @appointment = @doctor.appointments.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @doctor = Doctor.find(params[:doctor_id])
    ensure_doctor_availability

    @appointment = @doctor.appointments.new(patient_id: current_patient.id)

    respond_to do |format|
      format.html
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.update(appointment_params.merge(active: false))

    respond_to do |format|
      format.html { redirect_to doctor_appointment_path }
    end
  end

  def create
    @doctor = Doctor.find(params[:doctor_id])
    ensure_doctor_availability

    @appointment = @doctor.appointments.create(patient_id: current_patient.id, datetime: appointment_params[:datetime])

    respond_to do |format|
      format.html { redirect_to doctor_appointment_path(@doctor, @appointment), notice: t('.created') }
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.delete

    respond_to do |format|
      format.html { redirect_to root_path, notice: t('.deleted') }
    end
  end

  def available_hours
    @doctor = Doctor.find(params[:doctor_id])

    date = DateTime.parse(params[:date])

    busy_hours = @doctor.appointments.active.where(datetime: date.all_day).collect { |d| d.datetime.hour }
    working_hours = (9..17).to_a
    @available_hours = working_hours - busy_hours

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:datetime, :recommendations)
  end

  def fix_params
    date = params[:appointment].delete(:date)
    hour = params[:appointment].delete(:hour).to_i
    datetime = DateTime.parse(date).change(hour: hour)

    params[:appointment][:datetime] = datetime
  end

  def ensure_doctor_availability
    unless @doctor.available?
      respond_to do |format|
        format.html { redirect_to doctors_path, flash: { danger: t('doctors.show.busy') } }
      end
    end
  end

  def appointments_for_doctor
    @doctor = Doctor.find(params[:doctor_id])

    if current_patient && current_patient.of?(@doctor)
      # Show patient all their appointments with selected doctor
      @appointments = @doctor.appointments.where(patient_id: current_patient.id)
    elsif @doctor == current_doctor
      # Show doctor only their own appointments
      @appointments = @doctor.appointments
    else
      raise CanCan::AccessDenied
    end
  end

  def appointments_for_patient
    @patient = Patient.find(params[:patient_id])

    if current_doctor && @patient.of?(current_doctor)
      # Show doctor all their appointments with selected patient
      @appointments = @patient.appointments.where(doctor_id: current_doctor.id)
    elsif @patient == current_patient
      # Show patient only their own appointments
      @appointments = @patient.appointments
    else
      raise CanCan::AccessDenied
    end
  end
end
