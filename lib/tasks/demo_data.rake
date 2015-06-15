namespace :db do
  desc "Fill database with demo data"
  task :demo_data => :environment do
    if Rails.env.production?
      raise "\nI'm sorry, Dave, I can't do that.\n(You're asking me to drop your production database.)"
    end

#    ActiveRecord::Base.logger = Logger.new(STDOUT) if defined?(ActiveRecord::Base)

    Community.destroy_all
    Resident.destroy_all
    Assessor.destroy_all
    Admin.destroy_all
    User.destroy_all
    Assessment.destroy_all

    c1 = Community.create!(name: "One Village", city: "Roseville", state: "MN")
    c2 = Community.create!(name: "Two Villages", city: "Twin Cities", state: "MN")
    c3 = Community.create!(name: "Three Rivers", city: "St. Paul", state: "MN")
    r1a = Resident.create!(community: c1, first_name: "Carlos", last_name: "Santana", birthdate: "1963/11/15", gender: "Male", user_attributes: {email: "carlos@a.com", password: 'password', password_confirmation: 'password'})
    r1b = Resident.create!(community: c1, first_name: "Carol", last_name: "King", birthdate: "1953/11/15", gender: "Female", user_attributes: {email: "carol@a.com", password: 'password', password_confirmation: 'password'})
    r2 = Resident.create!(community: c2, first_name: "Freddie", last_name: "Mercury", birthdate: "1943/11/15", gender: "Male", user_attributes: {email: "freddy@a.com", password: 'password', password_confirmation: 'password'})
    r3 = Resident.create!(community: c3, first_name: "Joaine", last_name: "Mitchell", birthdate: "1933/11/15", gender: "Female", user_attributes: {email: "joanie@a.com", password: 'password', password_confirmation: 'password'})
    temp = Resident.create!(community: c1, first_name: "Annie", last_name: "Assessor", birthdate: "1943/11/15", gender: "Female")
    a1 = Assessor.create!(resident: temp, user_attributes: {email: "a1@a.com", password: 'password', password_confirmation: 'password'})
    a1.communities << c1 << c2
    temp = Resident.create!(community: c3, first_name: "Adam", last_name: "Assessor", birthdate: "1943/11/15", gender: "Male")
    a2 = Assessor.create!(resident: temp, user_attributes: {email: "a2@a.com", password: 'password', password_confirmation: 'password'})
    a2.communities << c3
    temp = Resident.create!(community: c1, first_name: "Andy", last_name: "Admin", birthdate: "1943/11/15", gender: "Male")
    admin = Admin.create!(resident: temp, user_attributes: {email: "admin@a.com", password: 'password', password_confirmation: 'password'})
    Assessment.create!(resident: r1a, date: Date.parse('Jan 15, 2015'), chair_stand: 5, arm_curl: 8, two_minute_step: 15, sit_and_reach: 18.25, back_scratch: 1.5, eight_foot_up_and_go: 4.3)
    Assessment.create!(resident: r1a, date: Date.parse('Feb 15, 2015'), chair_stand: 6, arm_curl: 10, two_minute_step: 20, sit_and_reach: 19.25, back_scratch: 1.5, eight_foot_up_and_go: 3.3)
    Assessment.create!(resident: r1a, date: Date.parse('Mar 15, 2015'), chair_stand: 7, arm_curl: 12, two_minute_step: 25, sit_and_reach: 20.25, back_scratch: 1.5, eight_foot_up_and_go: 2.3)
  end
end
