require 'open-uri'

desc "export images"
task export_images: :environment do
  DIR = '/Users/barry/Downloads/momenta-thumbs'
  Dir.mkdir(DIR) unless File.directory?(DIR)

  Work.all.each do |w|
    extension = File.extname(w.image.original_filename)
    filename = "#{w.first_name}_#{w.last_name}#{extension}"
    puts filename
    path = DIR + '/' + filename
    next if File.exist?(path)
    File.open(path, 'wb') do |f|
      url = w.image.url(:thumb).sub('development', 'production')
      puts url
      f.print(open(url).read)
    end
  end
end
