class CreateLineOfCredits < ActiveRecord::Migration
  def change
    create_table :line_of_credits do |t|
      t.decimal :balance
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
