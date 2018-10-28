class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.text :text
      t.references :user,        index: true, foreign_key: true
      t.references :chat_group, index: true, foreign_key: true
      t.timestamps
    end
  end
end
