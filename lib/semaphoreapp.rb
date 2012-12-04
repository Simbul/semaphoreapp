require 'net/http'
require 'net/https'
require 'openssl'
require 'uri'
require 'json'
require 'ostruct'

require "semaphoreapp/api"
require "semaphoreapp/branch"
require "semaphoreapp/branch_status"
require "semaphoreapp/build"
require "semaphoreapp/commit"
require "semaphoreapp/json_api"
require "semaphoreapp/project"
require "semaphoreapp/version"

module Semaphoreapp

  def self.auth_token= auth_token
    @@auth_token = auth_token
  end

  def self.auth_token
    @@auth_token
  end

end
