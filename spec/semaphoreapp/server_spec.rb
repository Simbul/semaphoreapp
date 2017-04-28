require 'spec_helper'

describe Semaphoreapp::Server do
  let(:project_hash_id) { ':hash_id' }

  describe ".build" do

    context "with a hash" do

      let(:test_hash){ fixture(:servers).first }

      subject{ Semaphoreapp::Server.build(test_hash, project_hash_id) }

      it "should call build_from_hash" do
        Semaphoreapp::Server.should_receive(:build_from_hash).with(test_hash, project_hash_id)
        subject
      end

    end

    context "with an array" do

      let(:test_array){ fixture(:servers) }
      subject{ Semaphoreapp::Server.build(test_array, project_hash_id) }

      it "should call build_from_array" do
        Semaphoreapp::Server.should_receive(:build_from_array).with(test_array, project_hash_id)
        subject
      end

    end

  end

  describe ".build_from_hash" do

    let(:test_hash){ fixture(:servers).first }
    subject{ Semaphoreapp::Server.build_from_hash(test_hash, project_hash_id) }

    it{ should be_an_instance_of Semaphoreapp::Server }

    fixture(:servers).first.each do |key, value|
      it "should have attribute #{key}" do
        subject.send(key).should == value
      end
    end

  end

  describe ".build_from_array" do

    let(:test_array){ fixture(:servers) }
    subject{ Semaphoreapp::Server.build_from_array(test_array, project_hash_id) }

    it{ should be_an_instance_of Array }

    it "should call build_from_hash for all the hashes in the array" do
      test_array.each do |test_hash|
        Semaphoreapp::Server.should_receive(:build_from_hash).with(test_hash, project_hash_id)
      end

      subject
    end

  end

  describe ".all_by_project_hash_id" do

    let(:hash_id) { ':hash_id' }
    let(:servers) { fixture(:servers) }
    before{ Semaphoreapp::JsonApi.stub(:get_servers).and_return(servers) }
    subject{ Semaphoreapp::Server.all_by_project_hash_id(hash_id) }

    it{ should be_an_instance_of Array }

    it "should get servers JSON from the API" do
      Semaphoreapp::JsonApi.should_receive(:get_servers).with(hash_id)
      subject
    end

    it "should call Server.build with an array of servers" do
      Semaphoreapp::Server.should_receive(:build).with(servers, hash_id)
      subject
    end

  end

  describe ".find" do

    let(:servers){ Semaphoreapp::Server.build(fixture(:servers), ':hash_id') }
    let(:expected_server) { servers.first }
    before{ Semaphoreapp::Server.stub(:all_by_project_hash_id).with(':hash_id').and_return(servers) }
    subject{ Semaphoreapp::Server.find(':hash_id', expected_server.id) }

    it{ should be_an_instance_of Semaphoreapp::Server }
    it "should return the Server object with the specified server_id" do
      subject.should == expected_server
    end

    context "with the wrong server_id" do
      subject{ Semaphoreapp::Server.find(':hash_id', ':wrong_id') }
      it{ should be_nil }
    end

  end

  describe ".find_by_name" do

    let(:servers){ Semaphoreapp::Server.build(fixture(:servers), ':hash_id') }
    let(:expected_server) { servers.first }
    before{ Semaphoreapp::Server.stub(:all_by_project_hash_id).with(':hash_id').and_return(servers) }
    subject{ Semaphoreapp::Server.find_by_name(':hash_id', expected_server.name) }

    it{ should be_an_instance_of Semaphoreapp::Server }
    it "should return the Server object with the specified name" do
      subject.should == expected_server
    end

    context "with the wrong name" do
      subject{ Semaphoreapp::Server.find_by_name(':hash_id', ':wrong_name') }
      it{ should be_nil }
    end

  end

end
