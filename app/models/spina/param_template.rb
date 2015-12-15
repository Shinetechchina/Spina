module Spina
  class ParamTemplate < ActiveRecord::Base
    belongs_to :component_template
    default_scope { order('created_at ASC') }
  end 
end