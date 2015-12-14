module Spina
  class ParamTemplate < ActiveRecord::Base
    belongs_to :component_template
  end 
end