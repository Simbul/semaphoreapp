module Semaphoreapp
  class Api
    BASE_URL = 'https://semaphoreapp.com'
    API_URL = 'api/v1'

    def self.get_projects(auth_token=nil)
      set_auth_token(auth_token)
      send_request(projects_url).body
    end

    def self.get_branches(project_hash_id, auth_token=nil)
      set_auth_token(auth_token)
      send_request(branches_url(project_hash_id)).body
    end

    def self.get_branch_history(project_hash_id, id, auth_token=nil)
      set_auth_token(auth_token)
      send_request(branch_history_url(project_hash_id, id)).body
    end

    def self.get_branch_status(project_hash_id, id, auth_token=nil)
      set_auth_token(auth_token)
      send_request(branch_status_url(project_hash_id, id)).body
    end

    def self.projects_url
      url_with_auth_token("#{API_URL}/projects")
    end

    def self.branches_url(project_hash_id)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/branches")
    end

    def self.branch_history_url(project_hash_id, id)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/#{id}")
    end

    def self.branch_status_url(project_hash_id, id)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/#{id}/status")
    end

    def self.url_with_auth_token(url)
      "/#{url}?auth_token=#{Semaphoreapp.auth_token}"
    end


    private

    def self.send_request url
      https = setup_https(BASE_URL)
      https.start do |session|
        puts url if Semaphoreapp.debug?
        req = Net::HTTP::Get.new(url)
        session.request(req)
      end
    end

    def self.setup_https(endpoint)
      url   = URI.parse(endpoint)
      https = Net::HTTP.new(url.host, url.port)
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      https.use_ssl = true
      return https
    end

    def self.set_auth_token(auth_token)
      Semaphoreapp.auth_token = auth_token unless auth_token.nil?
    end
  end
end
