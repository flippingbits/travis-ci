class CreateArtifactsLogs < ActiveRecord::Migration
  def change
    create_table :artifacts_logs do |t|
      t.string  :message
      t.integer :task_id

      t.timestamps
    end
  end
end
