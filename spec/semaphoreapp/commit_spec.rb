require 'spec_helper'

describe Semaphoreapp::Commit do

  describe ".build" do

    let(:test_hash){ fixture(:commit) }
    subject{ Semaphoreapp::Commit.build(test_hash) }

    it{ should be_an_instance_of Semaphoreapp::Commit }

    fixture(:commit).each do |key, value|
      it "should have attribute #{key}" do
        subject.send(key).should == value
      end
    end

  end

end
