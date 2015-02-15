require 'open-uri'

desc "export images"
task export_images: :environment do
  DIR = '/Users/barry/Downloads/momenta-thumbs'
  unless File.directory?(DIR)
    Dir.mkdir(DIR)
  end

  Work.all.each do |w|
    filename = "#{w.first_name}_#{w.last_name}#{File.extname(w.image.original_filename)}"
    puts filename
    path = DIR + '/' + filename
    if File.exist?(path)
      puts "- aleady downloaded"
      next
    end
    File.open(path, 'wb') do |f|
      url = w.image.url(:thumb).sub('development', 'production')
      puts url
      f.print(open(url).read)
    end
  end
end
