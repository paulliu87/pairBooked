class CreateTimeslots < ActiveRecord::Migration[5.0]
  def change
    create_table  :timeslots do |t|
      t.integer   :initiator_id
      t.integer   :acceptor_id
      t.integer   :challenge_id
      t.datetime  :start_at
      t.datetime  :end_at

      t.timestamps
    end
  end
end
