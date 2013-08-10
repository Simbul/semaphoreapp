require 'spec_helper'

describe Semaphoreapp::Deploy do

  describe ".build" do
    let(:test_source){ { } }
    subject{ Semaphoreapp::Deploy.build(test_source, 'project_hash_id', 'deploy_number') }

    it "should persist project_hash_id" do
      subject.project_hash_id.should == 'project_hash_id'
    end

    it "should persist deploy_number" do
      subject.deploy_number.should == 'deploy_number'
    end

    context "with a hash" do
      let(:test_source){ fixture(:deploys).first }

      it "should call build_from_hash" do
        Semaphoreapp::Deploy.should_receive(:build_from_hash).with(test_source, 'project_hash_id', 'deploy_number')
        subject
      end

    end

    context "with an array" do
      let(:test_source){ fixture(:deploys) }

      it "should call build_from_array" do
        Semaphoreapp::Deploy.should_receive(:build_from_array).with(test_source, 'project_hash_id', 'deploy_number')
        subject
      end

    end

  end

  describe ".build_from_hash" do

    let(:test_hash){ fixture(:deploys).first }
    subject{ Semaphoreapp::Deploy.build_from_hash(test_hash, 'project_hash_id', 'deploy_number') }

    it{ should be_an_instance_of Semaphoreapp::Deploy }

    fixture(:deploys).first.reject{ |key| key == 'commit' }.each do |key, value|
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

    let(:test_array){ fixture(:deploys) }
    subject{ Semaphoreapp::Deploy.build_from_array(test_array, 'project_hash_id', 'deploy_number') }

    it{ should be_an_instance_of Array }

    it "should call build_from_hash for all the hashes in the array" do
      test_array.each do |test_hash|
        Semaphoreapp::Deploy.should_receive(:build_from_hash).with(test_hash, 'project_hash_id', 'deploy_number')
      end

      subject
    end

  end

end
