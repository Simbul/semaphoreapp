module Semaphoreapp
  class Branch < Base

    def get_status
      Semaphoreapp::BranchStatus.build( Semaphoreapp::JsonApi.get_branch_status(project_hash_id, id) )
    end

    def get_builds
      history = Semaphoreapp::JsonApi.get_branch_history(project_hash_id, id)
      Semaphoreapp::Build.build(history['builds'])
    end

    def self.find(project_hash_id, branch_id)
      all_by_project_hash_id(project_hash_id).find{ |branch| branch.id.to_s == branch_id.to_s }
    end

    def self.find_by_name(project_hash_id, name)
      all_by_project_hash_id(project_hash_id).find{ |branch| branch.name == name }
    end

    def self.find_master(project_hash_id)
      find_by_name(project_hash_id, 'master')
    end

    def self.all_by_project_hash_id(project_hash_id)
      build(Semaphoreapp::JsonApi.get_branches(project_hash_id), project_hash_id)
    end

    def self.build(source, project_hash_id)
      super(source, project_hash_id)
    end


    private

    def self.build_from_hash(branch, project_hash_id)
      super(branch) do |hash|
        hash['project_hash_id'] = project_hash_id
      end
    end

  end
end
