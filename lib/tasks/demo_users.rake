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

    community = Community.create(name: "The Village", city: "Roseville")
    resident = Resident.create(community: community, user_attributes: {email: "resident@name.com", password: 'password', password_confirmation: 'password'})
    assessor = Assessor.create(user_attributes: {email: "assessor@name.com", password: 'password', password_confirmation: 'password'})
    admin = Admin.create(user_attributes: {email: "admin@name.com", password: 'password', password_confirmation: 'password'})

  end
end
