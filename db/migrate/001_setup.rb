class AddContacts < ActiveRecord::Migration
  def change
    create_table "contacts", :force => true do |t|
      t.string   "channel"
      t.string   "channel_account"
      t.string   "server_name"
      t.string   "role_name"
      t.string   "account"
      t.string   "email"
      t.string   "phone"
      t.datetime "birthday"
      t.string   "profession"
      t.string   "learn_from"
      t.string   "gender"
    end
  end
end
