module Semaphoreapp
  class Build < OpenStruct

    def self.build(source)
      if source.is_a?(Hash)
        Semaphoreapp::Build.new(
          source.dup.tap do |hash|
            hash['commit'] = Semaphoreapp::Commit.build(hash['commit'])
          end
        )
      elsif source.is_a?(Array)
        source.map{ |build| Semaphoreapp::Build.build(build) }
      end
    end

  end
end
