class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.sting :chefname
      t.string :email
      t.timestamp
    end
  end
end
