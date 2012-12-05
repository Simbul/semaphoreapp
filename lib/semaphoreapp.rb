require 'net/http'
require 'net/https'
require 'openssl'
require 'uri'
require 'json'
require 'ostruct'

require "semaphoreapp/api"
require "semaphoreapp/base"
require "semaphoreapp/branch"
require "semaphoreapp/branch_status"
require "semaphoreapp/build"
require "semaphoreapp/commit"
require "semaphoreapp/json_api"
require "semaphoreapp/project"
require "semaphoreapp/version"

module Semaphoreapp
  @@debug = false

  def self.auth_token= auth_token
    @@auth_token = auth_token
  end

  def self.auth_token
    @@auth_token
  end

  def self.debug= debug
    @@debug = debug
  end

  def self.debug?
    @@debug
  end

end
