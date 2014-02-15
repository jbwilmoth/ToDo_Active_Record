require_relative '../../config/application'

class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.boolean :completed
      # t.datetime :completed

      t.timestamps
    end
  end
end
