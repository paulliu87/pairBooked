class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :username
      t.string :fullname
      t.string :email
      t.string :slack_name

      t.timestamps
    end
  end
end
