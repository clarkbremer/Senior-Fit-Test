class CreateNorms < ActiveRecord::Migration
  def change
    create_table :norms do |t|
      t.string :test
      t.string :gender
      t.integer :min_age
      t.integer :max_age
      t.decimal :scores, array: true
    end
  end
end
