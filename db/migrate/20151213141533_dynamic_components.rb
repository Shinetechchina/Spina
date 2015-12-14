class DynamicComponents < ActiveRecord::Migration
  def change
    create_table "spina_component_templates", force: :cascade do |t|
      t.string :name
      t.text :content, null:false
      t.string :use_for
      t.string :file_path, null:false 
      t.timestamps
    end

    create_table "spina_param_templates", force: :cascade do |t|
      t.string :name
      t.string :type
      t.belongs_to :spina_component_template
      t.timestamps
    end

    create_table "spina_components", force: :cascade do |t|
      t.belongs_to :spina_component_template
      t.belongs_to :spina_page
      t.timestamps
    end

    create_table "spina_params", force: :cascade do |t|
      t.string :name
      t.string :value
      t.belongs_to :spina_component
      t.timestamps
    end
  end
end
