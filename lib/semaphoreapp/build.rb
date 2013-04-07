module Semaphoreapp
  class Build < Base

    def get_information
      Semaphoreapp::BuildInformation.build(
        Semaphoreapp::JsonApi.get_build_information(project_hash_id, branch_id, build_number)
      )
    end

    def get_log
      Semaphoreapp::BuildLog.build(
        Semaphoreapp::JsonApi.get_build_log(project_hash_id, branch_id, build_number)
      )
    end

    def self.build(source, project_hash_id, branch_id)
      super(source, project_hash_id, branch_id)
    end


    private

    def self.build_from_hash(build, project_hash_id, branch_id)
      super do |hash|
        hash['commit'] = Semaphoreapp::Commit.build(hash['commit'])
        hash['project_hash_id'] = project_hash_id
        hash['branch_id'] = branch_id
      end
    end

  end
end
