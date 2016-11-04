class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table  :challenges do |t|
      t.datetime  :due_date
      t.string    :name

      t.timestamps
    end
  end
end
