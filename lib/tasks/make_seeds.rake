namespace :db do
  desc "Dump norms to seeds"
  task :make_seeds => :environment do
    if Rails.env.production?
      raise "\nI'm sorry, Dave, I can't do that.\n(You're asking me to drop your production database.)"
    end

    s = "Norm.create!([\n"

    norms = Norm.all
    norms.each do |norm|
        s << "{"
          norm.attributes.each do |k,v|
            next if k == 'id'
            if v.class == Array
                s << "#{k}: ["
                s << v.join(", ")
                s << "]"
            elsif v.class == String
                s << "#{k}: " << '"' << v << '", '
            else
              s << "#{k}: #{v.to_s}, "
            end
          end
        s << "},\n"
    end

    s << "])"
    puts s
  end
end
