module Semaphoreapp
  class JsonApi < Api
    def self.get_projects(auth_token=nil)
      JSON.parse(super)
    end

    def self.get_branches(project_hash_id, auth_token=nil)
      JSON.parse(super)
    end

    def self.get_branch_history(project_hash_id, id, auth_token=nil)
      JSON.parse(super)
    end

    def self.get_branch_status(project_hash_id, id, auth_token=nil)
      JSON.parse(super)
    end
  end
end
