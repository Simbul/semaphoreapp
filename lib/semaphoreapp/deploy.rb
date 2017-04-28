module Semaphoreapp
  class Deploy < Base

    def get_information
      Semaphoreapp::DeployInformation.build(
        Semaphoreapp::JsonApi.get_deploy_information(project_hash_id, server_id, deploy_number)
      )
    end

    def get_log
      Semaphoreapp::DeployLog.build(
        Semaphoreapp::JsonApi.get_deploy_log(project_hash_id, server_id, deploy_number)
      )
    end

    def self.build(source, project_hash_id, deploy_number)
      super(source, project_hash_id, deploy_number)
    end


    private

    def self.build_from_hash(build, project_hash_id, deploy_number)
      super do |hash|
        hash['commit'] = Semaphoreapp::Commit.build(hash['commit'])
        hash['project_hash_id'] = project_hash_id
        hash['deploy_number'] = deploy_number
      end
    end

  end
end
