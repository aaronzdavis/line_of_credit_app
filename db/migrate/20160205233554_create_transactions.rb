class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :transaction_type
      t.decimal :amount
      t.references :line_of_credit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
