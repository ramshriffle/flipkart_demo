# frozen_string_literal: true

# create user
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :type
      t.integer :mobile_no
      t.string :otp
      t.datetime :otp_sent_at
      t.boolean :verified, default: false

      t.timestamps
    end
  end
end
