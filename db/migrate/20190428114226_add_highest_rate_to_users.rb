class AddHighestRateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :highest_rate, :integer
  end
end
