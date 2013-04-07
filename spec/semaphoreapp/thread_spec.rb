require 'spec_helper'

describe Semaphoreapp::Thread do

  describe ".build" do

    context "with a hash" do

      let(:test_hash){ fixture(:build_log)['threads'].first }
      subject{ Semaphoreapp::Thread.build(test_hash) }

      it "should call build_from_hash" do
        Semaphoreapp::Thread.should_receive(:build_from_hash).with(test_hash)
        subject
      end

    end

  end

  describe ".build_from_hash" do

    let(:test_hash){ fixture(:build_log)['threads'].first }
    subject{ Semaphoreapp::Thread.build_from_hash(test_hash) }

    it{ should be_an_instance_of Semaphoreapp::Thread }

    fixture(:build_log)['threads'].first.reject{ |key| key == 'commands' }.each do |key, value|
      it "should have attribute #{key}" do
        subject.send(key).should == value
      end
    end

    context "with commands" do
      it "should have an array as the commands attribute" do
        subject.commands.should be_an_instance_of Array
      end

      it "should contain Command objects" do
        subject.commands.map(&:class).uniq.should == [Semaphoreapp::Command]
      end
    end

    context "without commands" do
      before{ test_hash.delete('commands') }
      it "should set the commands attribute to nil" do
        subject.commands.should be_nil
      end
    end

  end

end
