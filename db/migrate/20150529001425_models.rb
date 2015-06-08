class Models < ActiveRecord::Migration
  def change
    create_table(:communities) do |t|
      t.string :name
      t.string :city
      t.string :state
    end

    create_table(:assessments) do |t|
      t.belongs_to :resident, index: true
      t.date :date
      t.integer :chair_stand
      t.integer :arm_curl
      t.integer :two_minute_step
      t.decimal :sit_and_reach
      t.decimal :back_scratch
      t.decimal :eight_foot_up_and_go
    end

    create_table(:residents) do |t|
      t.belongs_to :community, index: true
    end

    create_table(:assessors) do |t|
    end

    create_table(:admins) do |t|
    end

    create_table(:assessors_communities, id: false) do |t|
      t.belongs_to :community, index: true
      t.belongs_to :assessor, index: true
    end

    add_reference :users, :person, polymorphic: true, index: true

    remove_column :users, :role, :integer
  end
end
