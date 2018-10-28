class CreateChatGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_groups do |t|
      t.string :name, null: false, default: ""
      t.timestamps
    end
  end
end
