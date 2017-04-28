module Semaphoreapp
  class DeployInformation < Base

    private

    def self.build_from_hash(deploy_information)
      super do |hash|
        hash['commit'] = Semaphoreapp::Commit.build(hash['commit'])
      end
    end

  end
end
