module Semaphoreapp
  class Branch < OpenStruct
    def initialize(project_hash_id, hash)
      hash['project_hash_id'] = project_hash_id
      hash['commit'] = Commit.from_hash(hash['commit'])
      super(hash)
    end

    def get_status
      Semaphoreapp::BranchStatus.new( Semaphoreapp::JsonApi.get_branch_status(project_hash_id, id) )
    end

    def get_builds
      history = Semaphoreapp::JsonApi.get_branch_history(project_hash_id, id)
      Semaphoreapp::Build.all_from_hash(history['builds'])
    end

    def self.find(project_hash_id, branch_id)
      all_from_project_hash_id(project_hash_id).find{ |branch| branch.id.to_s == branch_id.to_s }
    end

    def self.find_by_name(project_hash_id, name)
      all_from_project_hash_id(project_hash_id).find{ |branch| branch.name == name }
    end

    def self.find_master(project_hash_id)
      find_by_name(project_hash_id, 'master')
    end

    def self.all_from_hash(project_hash_id, hash)
      hash.map{ |branch|
        Branch.new(project_hash_id, branch)
      }
    end

    def self.all_from_project_hash_id(project_hash_id)
      Semaphoreapp::Branch.all_from_hash(
        project_hash_id,
        Semaphoreapp::JsonApi.get_branches(project_hash_id)
      )
    end
  end
end
