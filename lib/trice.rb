require 'active_support/all'

require 'trice/controller_methods'
require 'trice/errors'
require 'trice/reference_time'
require 'trice/reference_time_accessor'
require 'trice/version'

module Trice
  extend ReferenceTimeAccessor

  mattr_accessor :support_requested_at_stubbing
end
