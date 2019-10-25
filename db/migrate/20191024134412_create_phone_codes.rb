class CreatePhoneCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_codes do |t|
      t.integer :prefix, null: false
      t.integer :max_len
      t.integer :min_len
      t.string :usage
      t.string :comment

      t.timestamps
    end
  end
end
