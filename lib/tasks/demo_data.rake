namespace :db do
  desc "Fill database with demo data"
  task :demo_data => :environment do
    if Rails.env.production?
      raise "\nI'm sorry, Dave, I can't do that.\n(You're asking me to drop your production database.)"
    end

    Community.destroy_all
    Resident.destroy_all
    Assessor.destroy_all
    Admin.destroy_all
    User.destroy_all

    c1 = Community.create(name: "One Village", city: "Roseville", state: "MN")
    c2 = Community.create(name: "Two Villages", city: "Twin Cities", state: "MN")
    c3 = Community.create(name: "Three Rivers", city: "St. Paul", state: "MN")
    r1a = Resident.create(community: c1, name: "One A Resident", user_attributes: {email: "r1a@a.com", password: 'password', password_confirmation: 'password'})
    r1b = Resident.create(community: c1, name: "One B Resident", user_attributes: {email: "r1b@a.com", password: 'password', password_confirmation: 'password'})
    r2 = Resident.create(community: c2, name: "Two Resident", user_attributes: {email: "r2@a.com", password: 'password', password_confirmation: 'password'})
    r3 = Resident.create(community: c3, name: "Three Resident", user_attributes: {email: "r3@a.com", password: 'password', password_confirmation: 'password'})
    a1 = Assessor.create(name: "Annie Assessor", user_attributes: {email: "a1@a.com", password: 'password', password_confirmation: 'password'})
    a1.communities << c1 << c2
    a2 = Assessor.create(name: "Adam Assessor", user_attributes: {email: "a2@a.com", password: 'password', password_confirmation: 'password'})
    a2.communities << c3
    admin = Admin.create(name: "Andy Admin", user_attributes: {email: "admin@a.com", password: 'password', password_confirmation: 'password'})

  end
end
