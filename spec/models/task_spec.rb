require 'spec_helper'

describe ::Task do
  attr_reader :build, :task

  let!(:build) { Factory(:build, :config => { :rvm => ['1.8.7', '1.9.2'] }) }
  let!(:task)  { build.matrix.first }

  context :append_log! do
    it "appends chars to the log artifact" do
      line = "$ bundle install --pa"
      Artifact::Log.any_instance.expects(:append).with(line)
      task.append_log!(line)
    end

    it 'notifies observers' do
      Travis::Notifications.expects(:dispatch).with('task:test:log', task, :build => { :_log => 'chars' })
      Task::Test.append_log!(task.id, 'chars')
    end
  end
end
