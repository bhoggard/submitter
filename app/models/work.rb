class Work < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :phone, :committee_member, :title, :year, :materials,
                  :height, :width, :length, :edition, :estimated_value, :courtesy, :image, :website
  validates_presence_of :first_name, :last_name, :phone, :committee_member, :title, :year, :materials, :height, :width
  validates :email,
            presence: true,
            format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates_numericality_of :height, presence: true, greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 18, only_integer: true
  validates_numericality_of :width, presence: true, greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 18, only_integer: true
  validates_numericality_of :length, greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 18, only_integer: true, allow_nil: true
  validates_format_of :website, with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, allow_blank: true

  has_attached_file :image,
                    styles: {
                      thumb: '160x120#',
                      large: '600x600>'
                    },
                    convert_options: { all: '-strip' },
                    storage: :s3,
                    s3_credentials: { access_key_id: Rails.configuration.aws_id, secret_access_key: Rails.configuration.aws_secret },
                    bucket: "i.#{Rails.env}.artcat.com",
                    s3_host_alias: "cdn.#{Rails.env}.artcat.com",
                    s3_protocol: 'http',
                    url: ':s3_alias_url',
                    hash_secret: Rails.configuration.asset_hash_secret,
                    hash_data: ":class/:attachment/:id/:style/:timestamp",
                    path: "submitter/:class/:id_partition/:hash.:extension",
                    default_url: '/assets/pixel.gif',
                    use_timestamp: false

  validates_attachment_content_type :image, content_type: %r{image/.*}
  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 500.kilobytes

  def artist_name
    "#{first_name} #{last_name}"
  end

  require 'csv'
  COLUMNS = %w(first_name last_name email phone committee_member title year materials
               height width length edition estimated_value website)

  def self.to_csv
    csv_string = CSV.generate do |csv|
      columns = Array.new(COLUMNS)
      columns << 'courtesy'
      csv << columns
      Work.order('last_name, first_name, title').each do |work|
        data = []
        COLUMNS.each do |i|
          data << work.send(i)
        end
        data << (work.courtesy.present? ? work.courtesy : 'the artist')
        csv << data.dup
      end
    end
  end
end
