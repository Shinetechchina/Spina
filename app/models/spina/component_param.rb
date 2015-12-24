module Spina
  class ComponentParam < ActiveRecord::Base
    belongs_to :component
    default_scope { order('created_at ASC') }
    has_many :page_component_params, dependent: :destroy
  end
end
