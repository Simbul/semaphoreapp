module Semaphoreapp
  class Thread < Base


    private

    def self.build_from_hash(branch_status)
      super do |hash|
        hash['commands'] = Semaphoreapp::Command.build(hash['commands'])
      end
    end

  end
end
