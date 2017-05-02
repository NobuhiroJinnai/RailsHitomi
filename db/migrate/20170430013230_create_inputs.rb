class CreateInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :inputs do |t|
      t.string :user_id
      t.string :input
      t.string :os

      t.timestamps
    end
  end
end
