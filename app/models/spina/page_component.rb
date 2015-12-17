module Spina
  class PageComponent < ActiveRecord::Base
    has_many :component_values, dependent: :destroy
  end
end
