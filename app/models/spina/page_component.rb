module Spina
  class PageComponent < ActiveRecord::Base
    has_many :page_component_params, dependent: :destroy
    accepts_nested_attributes_for :page_component_params, reject_if: :all_blank, allow_destroy: true

    belongs_to :component
    after_commit :initial_page_component_params, on: :create

    delegate :name, :use_for, :file_path,  to: :component, allow_nil: true

    private
    def initial_page_component_params
      begin
        component.component_params.each do |component_param|
          page_component_params.create(component_param_id: component_param.id)
        end
      rescue Exception => e
        errors.add(:base, e.message)
        return false
      end
    end

  end
end
