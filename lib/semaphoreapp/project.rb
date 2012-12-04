module Semaphoreapp
  class Project < OpenStruct

    def get_branches
      Semaphoreapp::Branch.all_by_project_hash_id(hash_id)
    end

    def master_branch_status
      branches.find{ |branch_status| branch_status.branch_name == 'master'}
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

    def self.build(source)
      if source.is_a?(Hash)
        Semaphoreapp::Project.new(
          source.dup.tap do |hash|
            hash['branches'] = Semaphoreapp::BranchStatus.build(hash['branches'])
          end
        )
      elsif source.is_a?(Array)
        source.map{ |project| Semaphoreapp::Project.build(project) }
      end
    end

  end
end
