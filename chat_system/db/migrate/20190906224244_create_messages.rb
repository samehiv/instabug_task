class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :number
      t.references :chat
      t.text :body

      t.index %i[chat_id number], unique: true
      t.index %i[number chat_id], unique: true

      t.timestamps
    end
  end
end
