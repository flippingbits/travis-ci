require 'spec_helper'

describe QueuesController, :type => :controller do
  let(:first_job)  { Factory.create(:test, :number => '3') }
  let(:second_job) { Factory.create(:test, :number => '3.1') }

  subject do
    first_job.start!
    second_job.start!
    get :index, :format => :json
    ActiveSupport::JSON.decode(response.body)
  end

  it 'index lists all jobs on the queue' do
    should == [
      { 'id' => first_job.id, 'number' => '3',   'commit' => '62aae5f70ceee39123ef', 'repository' => { 'id' => first_job.repository.id, 'slug' => 'svenfuchs/repository-1' } },
      { 'id' => second_job.id, 'number' => '3.1', 'commit' => '62aae5f70ceee39123ef', 'repository' => { 'id' => second_job.repository.id, 'slug' => 'svenfuchs/repository-2' } },
    ]
  end
end
