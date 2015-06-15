namespace :pokemon do
  desc "insert pokemon image"
  task :insert_image => :environment do
    open('/lib/tasks/images.json') do |f|
      while line = f.gets
        data = JSON.parse(line)
        name = data['name']
        image_url = data['image_url']

        Pokemon.where(name:name).update_attributes(
          :image => image_url
        )
      end
    end
  end
end