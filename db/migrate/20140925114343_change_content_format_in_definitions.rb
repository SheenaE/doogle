class ChangeContentFormatInDefinitions < ActiveRecord::Migration
  def change
    change_column :definitions, :content, :text
  end
end
