require 'spec_helper'

describe QueuesController, :type => :controller do
  before(:each) do
    @first_job  = Factory.create(:test, :number => '3')
    @second_job = Factory.create(:test, :number => '3.1')
  end

  it 'index lists all jobs on the queue' do
    get :index, :format => :json
    jobs = ActiveSupport::JSON.decode(response.body)
    jobs.should include({ 'id' => @first_job.id, 'number' => '3',   'commit' => '62aae5f70ceee39123ef', 'repository' => { 'id' => @first_job.repository.id, 'slug' => 'svenfuchs/repository-1' } })
    jobs.should include({ 'id' => @second_job.id, 'number' => '3.1', 'commit' => '62aae5f70ceee39123ef', 'repository' => { 'id' => @second_job.repository.id, 'slug' => 'svenfuchs/repository-2' } })
  end
end
