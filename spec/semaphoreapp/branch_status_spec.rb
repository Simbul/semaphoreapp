require 'spec_helper'

describe Semaphoreapp::BranchStatus do

  describe ".build" do

    context "with a hash" do

      let(:test_hash){ fixture(:branch_status) }
      subject{ Semaphoreapp::BranchStatus.build(test_hash) }

      it "should call build_from_hash" do
        Semaphoreapp::BranchStatus.should_receive(:build_from_hash).with(test_hash)
        subject
      end

    end

  end

  describe ".build_from_hash" do

    let(:test_hash){ fixture(:branch_status) }
    subject{ Semaphoreapp::BranchStatus.build_from_hash(test_hash) }

    it{ should be_an_instance_of Semaphoreapp::BranchStatus }

    fixture(:branch_status).reject{ |key| key == 'commit' }.each do |key, value|
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

end
