class CreateTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.integer :priority
      t.string :category
      t.references :user, null: false, foreign_key: true
      t.integer :assigned_to_id

      t.timestamps
    end
  end
end
