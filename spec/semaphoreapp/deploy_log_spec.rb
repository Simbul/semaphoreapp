require 'spec_helper'

describe Semaphoreapp::DeployLog do

  describe ".build" do

    context "with a hash" do

      let(:test_hash){ fixture(:deploy_log) }
      subject{ Semaphoreapp::DeployLog.build(test_hash) }

      it "should call build_from_hash" do
        Semaphoreapp::DeployLog.should_receive(:build_from_hash).with(test_hash)
        subject
      end

    end

  end

  describe ".build_from_hash" do

    let(:test_hash){ fixture(:deploy_log) }
    subject{ Semaphoreapp::DeployLog.build_from_hash(test_hash) }

    it{ should be_an_instance_of Semaphoreapp::DeployLog }

    fixture(:deploy_log).reject{ |key| key == 'threads' }.each do |key, value|
      it "should have attribute #{key}" do
        subject.send(key).should == value
      end
    end

    context "with threads" do
      it "should have an array as the threads attribute" do
        subject.threads.should be_an_instance_of Array
      end

      it "should contain Thread objects" do
        subject.threads.map(&:class).uniq.should == [Semaphoreapp::Thread]
      end
    end

    context "without threads" do
      before{ test_hash.delete('threads') }
      it "should set the threads attribute to nil" do
        subject.threads.should be_nil
      end
    end

  end

end
