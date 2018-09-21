module Semaphoreapp
  class JsonApi < Api
    def self.get_projects(options={})
      raise_if_error(JSON.parse(super))
    end

    def self.get_branches(project_hash_id, options={})
      raise_if_error(JSON.parse(super))
    end

    def self.get_branch_history(project_hash_id, id, options={})
      raise_if_error(JSON.parse(super))
    end

    def self.get_branch_status(project_hash_id, id, options={})
      raise_if_error(JSON.parse(super))
    end

    def self.launch_build(project_hash_id, id, options={})
      raise_if_error(JSON.parse(super))
    end

    def self.get_build_information(project_hash_id, id, build_number, options={})
      raise_if_error(JSON.parse(super))
    end

    def self.get_build_log(project_hash_id, id, build_number, options={})
      raise_if_error(JSON.parse(super))
    end

    def self.get_servers(project_hash_id, options={})
      raise_if_error(JSON.parse(super))
    end

    def self.get_server_status(project_hash_id, id, options={})
      raise_if_error(JSON.parse(super))
    end

    def self.get_server_history(project_hash_id, id, options={})
      raise_if_error(JSON.parse(super))
    end

    def self.get_deploy_information(project_hash_id, id, deploy_number, options={})
      raise_if_error(JSON.parse(super))
    end

    def self.get_deploy_log(project_hash_id, id, deploy_number, options={})
      raise_if_error(JSON.parse(super))
    end

    private

    def self.raise_if_error(obj)
      raise Semaphoreapp::Api::Error, obj['error'] if obj.is_a?(Hash) && obj.has_key?('error')
      obj
    end
  end
end
