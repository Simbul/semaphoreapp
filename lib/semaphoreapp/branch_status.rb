module Semaphoreapp
  class BranchStatus < OpenStruct

    def self.build(source)
      if source.is_a?(Hash)
        Semaphoreapp::BranchStatus.new(
          source.dup.tap do |hash|
            hash['commit'] = Semaphoreapp::Commit.build(hash['commit'])
          end
        )
      elsif source.is_a?(Array)
        source.map{ |branch_status| Semaphoreapp::BranchStatus.build(branch_status) }
      end
    end

  end
end
