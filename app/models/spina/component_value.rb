module Spina
  class ComponentValue < ActiveRecord::Base
    belongs_to :component_param
  end
end
