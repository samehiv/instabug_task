class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number
      t.references :application
      t.integer :messages_count, default: 0

      t.timestamps

      t.index %i[application_id number], unique: true
      t.index %i[number application_id], unique: true
    end
  end
end
