class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, default: ''
      t.string :last_name, default: ''
      t.integer :role, default: 0
      t.boolean :email_verified, default: false
      t.string :email_verification_token
      t.string :password_digest
      t.string :reset_password_token
      t.timestamp :reset_password_token_expires_at
      t.timestamp :reset_password_email_sent_at
      t.timestamps
    end
  end
end
