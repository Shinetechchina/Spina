module Spina
  class Component < ActiveRecord::Base
    belongs_to :user
    has_many :component_params, dependent: :destroy
    accepts_nested_attributes_for :component_params, reject_if: :all_blank, allow_destroy: true

    validates :content, presence: true
    validates :name, presence: true, uniqueness: true

    before_save :create_component_template
    after_destroy :destroy_component_template

    private
    def create_component_template
      path = Rails.root.join('public', 'static', 'javascripts', 'components', "#{user.name}")
      FileUtils.mkdir_p(path) unless Dir.exist?(path)
      self.file_path = path.join("#{name.parameterize}.es6.jsx").to_s

      if content_changed?
        File.open(file_path, 'w+') do |f|
         f.write(content)
        end
      end
    end

    def destroy_component_template
      File.delete(file_path) if File.exist?(file_path)
    end
  end
end
