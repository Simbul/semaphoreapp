require 'spec_helper'

describe Semaphoreapp::Branch do
  let(:project_hash_id) { ':hash_id' }

  describe ".build" do

    context "with a hash" do

      let(:test_hash){ fixture(:branches).first }

      subject{ Semaphoreapp::Branch.build(project_hash_id, test_hash) }

      it "should call build_from_hash" do
        Semaphoreapp::Branch.should_receive(:build_from_hash).with(project_hash_id, test_hash)
        subject
      end

    end

    context "with an array" do

      let(:test_array){ fixture(:branches) }
      subject{ Semaphoreapp::Branch.build(project_hash_id, test_array) }

      it "should call build_from_array" do
        Semaphoreapp::Branch.should_receive(:build_from_array).with(project_hash_id, test_array)
        subject
      end

    end

  end

  describe ".build_from_hash" do

    let(:test_hash){ fixture(:branches).first }
    subject{ Semaphoreapp::Branch.build_from_hash(project_hash_id, test_hash) }

    it{ should be_an_instance_of Semaphoreapp::Branch }

    fixture(:branches).first.each do |key, value|
      it "should have attribute #{key}" do
        subject.send(key).should == value
      end
    end

  end

  describe ".build_from_array" do

    let(:test_array){ fixture(:branches) }
    subject{ Semaphoreapp::Branch.build_from_array(project_hash_id, test_array) }

    it{ should be_an_instance_of Array }

    it "should call build_from_hash for all the hashes in the array" do
      test_array.each do |test_hash|
        Semaphoreapp::Branch.should_receive(:build_from_hash).with(project_hash_id, test_hash)
      end

      subject
    end

  end

end
