task delete_old_timeslots: :environment do
  Timeslot.clean_up
end
