require 'spec_helper'

describe Semaphoreapp::Project do

  describe ".build" do

    context "with a hash" do

      let(:test_hash){ fixture(:projects).first }

      subject{ Semaphoreapp::Project.build(test_hash) }

      it "should call build_from_hash" do
        Semaphoreapp::Project.should_receive(:build_from_hash).with(test_hash)
        subject
      end

    end

    context "with an array" do

      let(:test_array){ fixture(:projects) }
      subject{ Semaphoreapp::Project.build(test_array) }

      it "should call build_from_array" do
        Semaphoreapp::Project.should_receive(:build_from_array).with(test_array)
        subject
      end

    end

  end

  describe ".build_from_hash" do

    let(:test_hash){ fixture(:projects).first }
    subject{ Semaphoreapp::Project.build_from_hash(test_hash) }

    it{ should be_an_instance_of Semaphoreapp::Project }

    fixture(:projects).first.reject{ |key| key == 'branches' || key == 'servers' }.each do |key, value|
      it "should have attribute #{key}" do
        subject.send(key).should == value
      end
    end

    context "with branch statuses" do
      it "should have an array of BranchStatus object as the 'branches' attribute" do
        subject.branches.should be_an_instance_of Array
        subject.branches.each{ |branch| branch.should be_an_instance_of Semaphoreapp::BranchStatus }
      end
    end

    context "without branch statuses" do
      before{ test_hash.delete('branches') }
      it "should set the 'branches' attribute to nil" do
        subject.branches.should be_nil
      end
    end

    context "with server statuses" do
      it "should have an array of ServerStatus objects as the 'servers' attribute" do
        subject.servers.should be_an_instance_of Array
        subject.servers.each{ |server| server.should be_an_instance_of Semaphoreapp::ServerStatus }
      end
    end

    context "without server statuses" do
      before{ test_hash.delete('servers') }
      it "should set the 'servers' attribute to nil" do
        subject.servers.should be_nil
      end
    end

  end

  describe ".build_from_array" do

    let(:test_array){ fixture(:projects) }
    subject{ Semaphoreapp::Project.build_from_array(test_array) }

    it{ should be_an_instance_of Array }

    it "should call build_from_hash for all the hashes in the array" do
      test_array.each do |test_hash|
        Semaphoreapp::Project.should_receive(:build_from_hash).with(test_hash)
      end

      subject
    end

  end

end
