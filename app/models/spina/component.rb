module Spina
  class Component < ActiveRecord::Base
    has_many :component_params, dependent: :destroy
  end 
end