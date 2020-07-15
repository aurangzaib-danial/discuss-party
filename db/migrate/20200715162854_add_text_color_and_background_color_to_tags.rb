class AddTextColorAndBackgroundColorToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :text_color, :string, default: '#FFFFFF', null: false
    add_column :tags, :background_color, :string, default: '#17a2b8', null: false
  end
end
