module Semaphoreapp
  class Project < Base

    def get_branches
      Semaphoreapp::Branch.all_by_project_hash_id(hash_id)
    end

    def get_servers
      Semaphoreapp::Server.all_by_project_hash_id(hash_id)
    end

    def master_branch_status
      branches.find{ |branch_status| branch_status.branch_name == 'master'}
    end

    def build(branch)
      Semaphoreapp::JsonApi.launch_build(self.hash_id, branch)
    end

    def self.all
      build(Semaphoreapp::JsonApi.get_projects)
    end

    def self.find(project_hash_id)
      all.find{ |project| project.hash_id == project_hash_id }
    end

    def self.find_by_name(name)
      all.find{ |project| project.name == name }
    end


    private

    def self.build_from_hash(project)
      super do |hash|
        hash['branches'] = Semaphoreapp::BranchStatus.build(hash['branches'])
        hash['servers'] = Semaphoreapp::ServerStatus.build(hash['servers'])
      end
    end

  end
end
