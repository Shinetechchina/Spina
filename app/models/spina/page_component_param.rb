module Spina
  class PageComponentParam < ActiveRecord::Base
    belongs_to :component_param
    delegate :name, :use_for, to: :component_param, allow_nil: true
  end
end
