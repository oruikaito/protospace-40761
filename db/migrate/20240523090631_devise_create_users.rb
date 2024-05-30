# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name,               null: false
      t.text   :profile,            null: false
      t.text   :occupation,         null: false
      t.text   :position,           null: false

      t.timestamps null: false
    end
  end
end
