class ChangeYearToDateInBooks < ActiveRecord::Migration[6.0]
  def up
    change_column :books, :year, 'date USING CAST(year AS date)'
  end

  def down
    change_column :books, :year, :string
  end
end
