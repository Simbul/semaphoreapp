module Semaphoreapp
  class BranchStatus < OpenStruct

    def self.build(source)
      if source.is_a?(Hash)
        build_from_hash(source)
      elsif source.is_a?(Array)
        build_from_array(source)
      end
    end


    private

    def self.build_from_hash(branch_status)
      Semaphoreapp::BranchStatus.new(
        branch_status.dup.tap do |hash|
          hash['commit'] = Semaphoreapp::Commit.build(hash['commit'])
        end
      )
    end

    def self.build_from_array(branch_statuses)
      branch_statuses.map{ |branch_status| Semaphoreapp::BranchStatus.build_from_hash(branch_status) }
    end

  end
end
