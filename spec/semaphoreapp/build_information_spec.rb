require 'spec_helper'

describe Semaphoreapp::BuildInformation do

  describe ".build" do

    context "with a hash" do

      let(:test_hash){ fixture(:build_information) }
      subject{ Semaphoreapp::BuildInformation.build(test_hash) }

      it "should call build_from_hash" do
        Semaphoreapp::BuildInformation.should_receive(:build_from_hash).with(test_hash)
        subject
      end

    end

  end

  describe ".build_from_hash" do

    let(:test_hash){ fixture(:build_information) }
    subject{ Semaphoreapp::BuildInformation.build_from_hash(test_hash) }

    it{ should be_an_instance_of Semaphoreapp::BuildInformation }

    fixture(:build_information).reject{ |key| key == 'commits' }.each do |key, value|
      it "should have attribute #{key}" do
        subject.send(key).should == value
      end
    end

    context "with commits" do
      it "should have an array as the commits attribute" do
        subject.commits.should be_an_instance_of Array
      end

      it "should contain Commit objects" do
        subject.commits.map(&:class).uniq.should == [Semaphoreapp::Commit]
      end
    end

    context "without commits" do
      before{ test_hash.delete('commits') }
      it "should set the commits attribute to nil" do
        subject.commits.should be_nil
      end
    end

  end

end
