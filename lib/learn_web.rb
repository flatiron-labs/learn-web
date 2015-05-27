require 'faraday'
require 'oj'

require 'learn_web/version'
require 'learn_web/attribute_populatable'
require 'learn_web/client'

module LearnWeb
  include LearnWeb::AttributePopulatable
end
