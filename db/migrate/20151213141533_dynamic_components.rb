class DynamicComponents < ActiveRecord::Migration
  def change
    create_table "spina_components", force: :cascade do |t|
      t.string :name
      t.string :use_for
      t.text :content, null:false
      t.string :file_path, null:false
      t.timestamps
    end

    create_table "spina_component_params", force: :cascade do |t|
      t.string :name
      t.string :use_for
      t.belongs_to :component
      t.timestamps
    end

    create_table "spina_page_components", force: :cascade do |t|
      t.belongs_to :page
      t.belongs_to :component
      t.timestamps
    end

    create_table "spina_page_component_params", force: :cascade do |t|
      t.string :param_value
      t.belongs_to :page_component
      t.belongs_to :component_param
      t.timestamps
    end
  end
end
