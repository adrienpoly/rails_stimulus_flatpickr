# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[update destroy]

  def index
    @appointments = Appointment.up_comings(60)
    @appointment = Appointment.new
    @next_appointment = Appointment.next
    @dates_to_disable = @appointments.pluck(:start_at)
  end

  def create
    redirect_to appointments_path if Appointment.create(appointment_params)
  end

  def update
    redirect_to appointments_path if @appointment.update(appointment_params)
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:start_at)
  end
end
