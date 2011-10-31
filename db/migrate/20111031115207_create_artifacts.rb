class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.string  :message
      t.integer :task_id
      t.string  :type

      t.timestamps
    end
  end
end
