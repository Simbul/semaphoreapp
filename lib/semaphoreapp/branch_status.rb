module Semaphoreapp
  class BranchStatus < Base


    private

    def self.build_from_hash(branch_status)
      super do |hash|
        hash['commit'] = Semaphoreapp::Commit.build(hash['commit'])
      end
    end

  end
end
