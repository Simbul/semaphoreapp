module Semaphoreapp
  class Build < OpenStruct

    def self.build(source)
      if source.is_a?(Hash)
        build_from_hash(source)
      elsif source.is_a?(Array)
        build_from_array(source)
      end
    end


    private

    def self.build_from_hash(build)
      Semaphoreapp::Build.new(
        build.dup.tap do |hash|
          hash['commit'] = Semaphoreapp::Commit.build(hash['commit'])
        end
      )
    end

    def self.build_from_array(builds)
      builds.map{ |build| Semaphoreapp::Build.build_from_hash(build) }
    end

  end
end
