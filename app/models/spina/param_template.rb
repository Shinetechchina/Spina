module Spina
  class ComponentParam < ActiveRecord::Base
    belongs_to :component
    default_scope { order('created_at ASC') }
  end
end
