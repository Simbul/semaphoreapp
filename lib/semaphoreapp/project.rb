module Semaphoreapp
  class Project < OpenStruct
    def initialize(hash)
      hash['branches'] = BranchStatus.all_from_hash(hash['branches'])
      super
    end

    def get_branches
      Semaphoreapp::Branch.all_from_hash(
        hash_id,
        Semaphoreapp::JsonApi.get_branches(hash_id)
      )
    end

    def master_branch_status
      branches.find{ |branch_status| branch_status.branch_name == 'master'}
    end

    def self.all
      all_from_hash(Semaphoreapp::JsonApi.get_projects)
    end

    def self.find(project_hash_id)
      all.find{ |project| project.hash_id == project_hash_id }
    end

    def self.find_by_name(name)
      all.find{ |project| project.name == name }
    end

    def self.all_from_hash(hash)
      hash.map{ |project| Project.new(project) }
    end
  end
end
