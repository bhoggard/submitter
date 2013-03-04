# make admin and normal user for dev
if Rails.env == 'development'
  u = User.find_by_name('admin')
  u.destroy unless u.blank?
  u = User.create(:name => 'admin', :password=>'password', :password_confirmation=>'password')
  u.save!

  # make works for us 
  (1..32).each do |i|
    work = Factory.build(:work)
    f = File.open("#{Rails.root}/app/assets/images/art#{i % 2 + 1}.jpg")
    work.image = f
    work.save!
  end

end

