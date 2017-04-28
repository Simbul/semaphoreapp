module Semaphoreapp
  class Server < Base

    def get_status
      Semaphoreapp::ServerStatus.build( Semaphoreapp::JsonApi.get_server_status(project_hash_id, id) )
    end

    def get_deploys
      history = Semaphoreapp::JsonApi.get_server_history(project_hash_id, id)
      Semaphoreapp::Deploy.build(history['deploys'], project_hash_id, id)
    end

    def self.find(project_hash_id, server_id)
      all_by_project_hash_id(project_hash_id).find{ |server| server.id.to_s == server_id.to_s }
    end

    def self.find_by_name(project_hash_id, name)
      all_by_project_hash_id(project_hash_id).find{ |server| server.name == name }
    end

    def self.all_by_project_hash_id(project_hash_id)
      build(Semaphoreapp::JsonApi.get_servers(project_hash_id), project_hash_id)
    end

    def self.build(source, project_hash_id)
      super(source, project_hash_id)
    end


    private

    def self.build_from_hash(server, project_hash_id)
      super(server) do |hash|
        hash['project_hash_id'] = project_hash_id
      end
    end

  end
end
