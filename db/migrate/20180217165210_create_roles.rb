class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string   :role_type
      t.string   :name

      t.timestamps
    end

    add_index :roles, :role_type, unique: true
    add_reference :users, :role
  end
end
