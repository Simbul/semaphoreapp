require 'spec_helper'

describe Semaphoreapp::Api do
  subject{ Semaphoreapp::Api }

  describe ".url_with_auth_token" do
    before{ Semaphoreapp.stub(:auth_token).and_return('test_token') }

    it "should append auth_token to the given URL" do
      subject.url_with_auth_token('test_url').should == '/test_url?auth_token=test_token'
    end

    context "with a page" do
      it "should append page to the given URL" do
        subject.url_with_auth_token('test_url', :page => ':page').should == '/test_url?auth_token=test_token&page=:page'
      end
    end
  end

  describe "URL generators" do
    before{ Semaphoreapp.stub(:auth_token).and_return('test_token') }
    before{ stub_const('Semaphoreapp::Api::API_URL', 'api_url') }

    describe ".projects_url" do
      subject{ Semaphoreapp::Api.projects_url }
      it{ should start_with '/api_url/projects' }
      it{ should end_with '?auth_token=test_token' }
    end

    describe ".branches_url" do
      subject{ Semaphoreapp::Api.branches_url(':hash_id') }
      it{ should start_with '/api_url/projects/:hash_id/branches' }
      it{ should end_with '?auth_token=test_token' }
    end

    describe ".branch_history_url" do
      subject{ Semaphoreapp::Api.branch_history_url(':hash_id', ':id') }
      it{ should start_with '/api_url/projects/:hash_id/:id' }
      it{ should end_with '?auth_token=test_token' }

      context "with a page" do
        subject{ Semaphoreapp::Api.branch_history_url(':hash_id', ':id', :page => ':page') }
        it{ should include 'page=:page' }
      end
    end

    describe ".branch_status_url" do
      subject{ Semaphoreapp::Api.branch_status_url(':hash_id', ':id') }
      it{ should start_with '/api_url/projects/:hash_id/:id/status' }
      it{ should end_with '?auth_token=test_token' }
    end

  end

  describe "getters" do
    let(:response){ mock(:response, :body => '') }
    before{ Semaphoreapp::Api.stub(:send_request).and_return(response) }
    before{ Semaphoreapp.stub(:auth_token).and_return('test_token') }

    describe ".get_projects" do
      it "should send a request to projects_url" do
        Semaphoreapp::Api.should_receive(:projects_url).and_return('projects_url')
        Semaphoreapp::Api.should_receive(:send_request).with('projects_url').and_return(response)

        Semaphoreapp::Api.get_projects
      end

      it "should not overwrite the auth_token" do
        Semaphoreapp::Api.should_receive(:set_auth_token).with({})
        Semaphoreapp::Api.get_projects
      end

      context "with auth_token" do
        it "should set the auth_token" do
          Semaphoreapp::Api.should_receive(:set_auth_token).with(hash_including(:auth_token => 'test_token'))
          Semaphoreapp::Api.get_projects(:auth_token => 'test_token')
        end
      end
    end

    describe ".get_branches" do
      it "should send a request to branches_url" do
        Semaphoreapp::Api.should_receive(:branches_url).with(':hash_id').and_return('branches_url')
        Semaphoreapp::Api.should_receive(:send_request).with('branches_url').and_return(response)

        Semaphoreapp::Api.get_branches(':hash_id')
      end

      it "should not overwrite the auth_token" do
        Semaphoreapp::Api.should_receive(:set_auth_token).with({})
        Semaphoreapp::Api.get_branches(':hash_id')
      end

      context "with auth_token" do
        it "should set the auth_token" do
          Semaphoreapp::Api.should_receive(:set_auth_token).with(hash_including(:auth_token => 'test_token'))
          Semaphoreapp::Api.get_branches(':hash_id', :auth_token => 'test_token')
        end
      end
    end

    describe ".get_branch_history" do
      it "should send a request to branch_history_url" do
        Semaphoreapp::Api.should_receive(:branch_history_url).with(':hash_id', ':id', {}).and_return('branch_history_url')
        Semaphoreapp::Api.should_receive(:send_request).with('branch_history_url').and_return(response)

        Semaphoreapp::Api.get_branch_history(':hash_id', ':id')
      end

      it "should not overwrite the auth_token" do
        Semaphoreapp::Api.should_receive(:set_auth_token).with({})
        Semaphoreapp::Api.get_branch_history(':hash_id', ':id')
      end

      context "with auth_token" do
        it "should set the auth_token" do
          Semaphoreapp::Api.should_receive(:set_auth_token).with(hash_including(:auth_token => 'test_token'))
          Semaphoreapp::Api.get_branch_history(':hash_id', ':id', :auth_token => 'test_token')
        end
      end

      context "with page" do
        it "should request the specified page" do
          Semaphoreapp::Api.should_receive(:branch_history_url).with(':hash_id', ':id', :page => ':page').and_return('branch_history_url')
          Semaphoreapp::Api.get_branch_history(':hash_id', ':id', :page => ':page')
        end
      end
    end

    describe ".get_branch_status" do
      it "should send a request to branch_status_url" do
        Semaphoreapp::Api.should_receive(:branch_status_url).with(':hash_id', ':id').and_return('branch_status_url')
        Semaphoreapp::Api.should_receive(:send_request).with('branch_status_url').and_return(response)

        Semaphoreapp::Api.get_branch_status(':hash_id', ':id')
      end

      it "should not overwrite the auth_token" do
        Semaphoreapp::Api.should_receive(:set_auth_token).with({})
        Semaphoreapp::Api.get_branch_status(':hash_id', ':id')
      end

      context "with auth_token" do
        it "should set the auth_token" do
          Semaphoreapp::Api.should_receive(:set_auth_token).with(hash_including(:auth_token => 'test_token'))
          Semaphoreapp::Api.get_branch_status(':hash_id', ':id', :auth_token => 'test_token')
        end
      end
    end

  end

end
