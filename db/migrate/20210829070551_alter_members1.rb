class AlterMembers1 < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :password_digest, :string
  end
end
