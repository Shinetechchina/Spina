module Spina
  class PageComponent < ActiveRecord::Base
    has_many :page_component_params, dependent: :destroy
    accepts_nested_attributes_for :page_component_params

    belongs_to :component

    delegate :name, :use_for, to: :component, allow_nil: true
  end
end
