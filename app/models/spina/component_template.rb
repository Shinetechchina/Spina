module Spina
  class ComponentTemplate < ActiveRecord::Base
    validates :content, presence: true
    validates :name, presence: true, uniqueness: true

    before_save :create_component_template
    after_destroy :destroy_component_template
    
    has_many :param_templates
    
    private
    def create_component_template
      path = Rails.root.join('app', 'assets', 'javascripts','default','js','components', "#{self.name.parameterize}.es6.jsx")
      File.open(path, 'w+') do |f|
        f.write(self.content)
      end   
      self.file_path = path
    end
    def destroy_component_template
      File.delete(self.file_path) if File.exist?(self.file_path)      
    end
  end 
end