module Semaphoreapp
  class JsonApi < Api
    def self.get_projects(auth_token=nil)
      raise_if_error(JSON.parse(super))
    end

    def self.get_branches(project_hash_id, auth_token=nil)
      raise_if_error(JSON.parse(super))
    end

    def self.get_branch_history(project_hash_id, id, auth_token=nil)
      raise_if_error(JSON.parse(super))
    end

    def self.get_branch_status(project_hash_id, id, auth_token=nil)
      raise_if_error(JSON.parse(super))
    end


    private

    def self.raise_if_error(obj)
      raise Semaphoreapp::Api::Error, obj['error'] if obj.is_a?(Hash) && obj.has_key?('error')
      obj
    end
  end
end
