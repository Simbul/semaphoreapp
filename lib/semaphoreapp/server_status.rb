module Semaphoreapp
  class ServerStatus < Base
    private

    def self.build_from_hash(server_status)
      super do |hash|
        hash['commit'] = Semaphoreapp::Commit.build(hash['commit'])
      end
    end

  end
end
