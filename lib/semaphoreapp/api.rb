module Semaphoreapp
  class Api
    class Error < RuntimeError; end

    BASE_URL = 'https://semaphoreci.com'
    API_URL = 'api/v1'

    def self.get_projects(options={})
      set_auth_token(options)
      send_request(projects_url).body
    end

    def self.get_branches(project_hash_id, options={})
      set_auth_token(options)
      send_request(branches_url(project_hash_id)).body
    end

    def self.get_branch_history(project_hash_id, id, options={})
      set_auth_token(options)
      send_request(branch_history_url(project_hash_id, id, options)).body
    end

    def self.get_branch_status(project_hash_id, id, options={})
      set_auth_token(options)
      send_request(branch_status_url(project_hash_id, id)).body
    end

    def self.launch_build(project_hash_id, id, options={})
      set_auth_token(options)
      post_request(build_launch_url(project_hash_id, id)).body
    end

    def self.get_build_information(project_hash_id, id, build_number, options={})
      set_auth_token(options)
      send_request(build_information_url(project_hash_id, id, build_number)).body
    end

    def self.get_build_log(project_hash_id, id, build_number, options={})
      set_auth_token(options)
      send_request(build_log_url(project_hash_id, id, build_number)).body
    end

    def self.get_servers(project_hash_id, options={})
      set_auth_token(options)
      send_request(servers_url(project_hash_id)).body
    end

    def self.get_server_status(project_hash_id, id, options={})
      set_auth_token(options)
      send_request(server_status_url(project_hash_id, id)).body
    end

    def self.get_server_history(project_hash_id, id, options={})
      set_auth_token(options)
      send_request(server_history_url(project_hash_id, id, options)).body
    end

    def self.get_deploy_information(project_hash_id, id, deploy_number, options={})
      set_auth_token(options)
      send_request(deploy_information_url(project_hash_id, id, deploy_number)).body
    end

    def self.get_deploy_log(project_hash_id, id, deploy_number, options={})
      set_auth_token(options)
      send_request(deploy_log_url(project_hash_id, id, deploy_number)).body
    end

    def self.projects_url
      url_with_auth_token("#{API_URL}/projects")
    end

    def self.branches_url(project_hash_id)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/branches")
    end

    def self.branch_history_url(project_hash_id, id, options={})
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/#{id}", options)
    end

    def self.branch_status_url(project_hash_id, id)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/#{id}/status")
    end

    def self.build_launch_url(project_hash_id, id)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/#{id}/build")
    end

    def self.build_information_url(project_hash_id, id, build_number)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/#{id}/builds/#{build_number}")
    end

    def self.build_log_url(project_hash_id, id, build_number)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/#{id}/builds/#{build_number}/log")
    end

    def self.servers_url(project_hash_id)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/servers")
    end

    def self.server_status_url(project_hash_id, id)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/servers/#{id}/status")
    end

    def self.server_history_url(project_hash_id, id, options={})
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/servers/#{id}", options)
    end

    def self.deploy_information_url(project_hash_id, id, deploy_number)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/servers/#{id}/deploys/#{deploy_number}")
    end

    def self.deploy_log_url(project_hash_id, id, deploy_number)
      url_with_auth_token("#{API_URL}/projects/#{project_hash_id}/servers/#{id}/deploys/#{deploy_number}/log")
    end

    def self.url_with_auth_token(url, options={})
      "/#{url}?auth_token=#{Semaphoreapp.auth_token}" << begin
        options[:page].nil? ? '' : "&page=#{options[:page]}"
      end
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

    def self.post_request url
      https = setup_https(BASE_URL)
      https.start do |session|
        puts url if Semaphoreapp.debug?
        req = Net::HTTP::Post.new(url)
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

    def self.set_auth_token(options)
      Semaphoreapp.auth_token = options[:auth_token] unless options[:auth_token].nil?
    end
  end
end
