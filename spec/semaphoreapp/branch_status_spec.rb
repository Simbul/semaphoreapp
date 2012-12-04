require 'spec_helper'

describe Semaphoreapp::BranchStatus do

  describe ".build" do

    context "with a hash" do

      let(:test_hash){ fixture(:branch_statuses).first }
      subject{ Semaphoreapp::BranchStatus.build(test_hash) }

      it "should call build_from_hash" do
        Semaphoreapp::BranchStatus.should_receive(:build_from_hash).with(test_hash)
        subject
      end

    end

    context "with an array" do

      let(:test_array){ fixture(:branch_statuses) }
      subject{ Semaphoreapp::BranchStatus.build(test_array) }

      it "should call build_from_array" do
        Semaphoreapp::BranchStatus.should_receive(:build_from_array).with(test_array)
        subject
      end

    end

  end

  describe ".build_from_hash" do

    let(:test_hash){ fixture(:branch_statuses).first }
    subject{ Semaphoreapp::BranchStatus.build_from_hash(test_hash) }

    it{ should be_an_instance_of Semaphoreapp::BranchStatus }

    fixture(:branch_statuses).first.reject{ |key| key == 'commit' }.each do |key, value|
      it "should have attribute #{key}" do
        subject.send(key).should == value
      end
    end

    context "with a commit" do
      it "should have a Commit object as the commit attribute" do
        subject.commit.should be_an_instance_of Semaphoreapp::Commit
      end
    end

    context "without a commit" do
      before{ test_hash.delete('commit') }
      it "should set the commit attribute to nil" do
        subject.commit.should be_nil
      end
    end

  end

  describe ".build_from_array" do

    let(:test_array){ fixture(:branch_statuses) }
    subject{ Semaphoreapp::BranchStatus.build_from_array(test_array) }

    it{ should be_an_instance_of Array }

    it "should call build_from_hash for all the hashes in the array" do
      test_array.each do |test_hash|
        Semaphoreapp::BranchStatus.should_receive(:build_from_hash).with(test_hash)
      end

      subject
    end

  end

end
