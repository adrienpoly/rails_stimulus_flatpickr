# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.date :start_at

      t.timestamps
    end
  end
end
