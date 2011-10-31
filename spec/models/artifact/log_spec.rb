require 'spec_helper'

describe Artifact::Log do
  describe "#append" do
    let(:log) { Factory.create(:log, :message => "") }

    it "appends streamed build log chunks" do
      lines = [
        "$ git clone --depth=1000 --quiet git://github.com/intridea/omniauth.git ~/builds/intridea/omniauth\n",
        "$ git checkout -qf 662af2708525b776aac580b10cc903ba66050e06\n",
        "$ bundle install --pa"
      ]
      0.upto(2) do |ix|
        log.append(lines[ix])
        assert_equal lines[0, ix + 1].join, log.reload.message
      end
    end
  end
end