module Spina
  class ComponentTemplate < ActiveRecord::Base
    validates :content, presence: true
    validates :name, presence: true, uniqueness: true

    before_save :create_component_template
    after_destroy :destroy_component_template

    has_many :param_templates, dependent: :destroy
    
    private
    def create_component_template
      File.open(file_path, 'w+') do |f|
        f.write(content)
      end   
    end
    def destroy_component_template
      File.delete(file_path) if File.exist?(file_path)      
    end
  end 
end