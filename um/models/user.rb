class User < Sequel::Model

 plugin :validation_helpers

  attr_accessor :password, :password_confirmation
  mount_uploader :avatar, AvatarUploader

  def validate
    validates_presence     :email
    #validates_presence     :role
    validates_presence     :password if password_required
    validates_presence     :password_confirmation if password_required
    validates_length_range 4..40, :password unless password.blank?
    errors.add(:password_confirmation, 'must confirm password') if !password.blank? && password != password_confirmation
    validates_length_range 3..100, :email unless email.blank?
    validates_unique       :email unless email.blank?
    #validates_format       /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :email unless email.blank?
    #validates_format       /[A-Za-z]/, :role unless role.blank?
  end

  # Callbacks
  def before_save
    encrypt_password
  end

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate(email, password)
    account = filter(Sequel.function(:lower, :email) => Sequel.function(:lower, email)).first
    account && account.has_password?(password) ? account : nil
  end

  ##
  # Replace ActiveRecord method.
  #
  def self.find_by_id(id)
    self[id] rescue nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(self.crypted_password) == password
  end

  private

  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(password) if password.present?
  end

  def password_required
    self.crypted_password.blank? || password.present?
  end


class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick #使用minimagick处理压缩图片，确保安装magickimage这个东东，ubuntu可以sudo apt-get install magickimage

  # Choose what kind of storage to use for this uploader: 
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir  #定义上传到哪个文件夹下
   # puts "store_dir =" + "um/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "um/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url  #可以定义默认图片，如过用户没有上传图片，则可以使用默认的图片
   # puts "default_url="+ "avatar/#{version_name}.png"
    "avatar/#{version_name}.png"
  end


#图片的处理，有不同版本大小，网站可以在不同的地方调用不同的图片大小
 version :normal do
    process :resize_to_fill => [48, 48]
  end

  version :small do
    process :resize_to_fill => [16, 16]
  end

  version :large do
    process :resize_to_fill => [64, 64]
  end

  version :big do
    process :resize_to_fill => [120, 120]
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
#指定上传文件的格式
  def extension_white_list
    %w(jpg jpeg gif png)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
  
end
