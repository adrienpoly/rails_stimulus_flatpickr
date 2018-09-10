# frozen_string_literal: true

class Appointment < ApplicationRecord
  validates :start_at, uniqueness: true

  scope :up_comings, ->(nb_days) {
                       where('start_at >= ? AND start_at < ?',
                             Time.zone.now,
                             Time.zone.now + nb_days.days).order(start_at: :asc)
                     }

  def self.next
    next_appointment = Time.zone.now.to_date
    next_appointment += 1.day while find_by(start_at: next_appointment)
    next_appointment
  end
end
