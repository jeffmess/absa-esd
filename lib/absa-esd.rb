require "absa-esd/version"
require "active_support/core_ext/string"
require "yaml"
require 'strata'

module Absa
  module Esd
    CONFIG_DIR = File.expand_path(File.dirname(__FILE__)) + "/config" 
  end
end

require 'absa-esd/transmission/set'
require 'absa-esd/transmission/record'
require 'absa-esd/transmission/document'
