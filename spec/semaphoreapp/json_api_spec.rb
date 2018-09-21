require 'spec_helper'

describe Semaphoreapp::JsonApi do

  describe ".raise_if_error" do
    context "with an error" do
      let(:error){ {'error' => 'error message'} }
      subject{ Semaphoreapp::JsonApi.raise_if_error(error) }

      it{ expect{ subject }.to raise_error Semaphoreapp::Api::Error }
    end

    context "with no error" do
      let(:obj){ Object.new }
      subject{ Semaphoreapp::JsonApi.raise_if_error(obj) }

      it{ expect{ subject }.not_to raise_error }

      it "should return its parameter without changes" do
        subject.should == obj
      end
    end
  end

end
