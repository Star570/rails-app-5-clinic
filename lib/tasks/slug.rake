namespace :slug do
  desc "generate slug"

  task :generate => :environment do    
    p "generate announcement slug start"
    Announcement.find_each(&:save)
    p "generate post slug start"
    Post.find_each(&:save)    
    p "generate message slug start"
    Message.find_each(&:save)   
    p "generate user slug start"
    User.find_each(&:save)   
    p "generate album slug start"
    Album.find_each(&:save)                        
  end

end
