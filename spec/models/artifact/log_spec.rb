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

  describe "#to_s" do
    let(:log) { Factory.build(:log) }

    context "given @message exists" do
      it "returns the message" do
        log.to_s.should eql(log.message)
      end
    end

    context "given @message does not exist" do
      it "returns an empty string" do
        log.message = nil
        log.to_s.should eql("")
      end
    end
  end
end