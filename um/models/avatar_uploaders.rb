class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick #使用minimagick处理压缩图片，确保安装magickimage这个东东，ubuntu可以sudo apt-get install magickimage

  # Choose what kind of storage to use for this uploader: 
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir  #定义上传到哪个文件夹下
   # puts "store_dir =" + "um/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
   # "um/images/avartar/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
   "um/images"
  end

  def default_url  #可以定义默认图片，如过用户没有上传图片，则可以使用默认的图片
        if original_filename
      # current_path 是 Carrierwave 上传过程临时创建的一个文件，有时间标记
      # 例如: /Users/jason/work/ruby-china/public/uploads/tmp/20131105-1057-46664-5614/_____2013-11-05___10.37.50.png
      @name ||= Digest::MD5.hexdigest(current_path)
      "#{@name}.#{file.extension}"
    end
   # puts "default_url="+ "avatar/#{version_name}.png"
    "#{version_name}.jpg"

  end

  def filename
    if original_filename
      # current_path 是 Carrierwave 上传过程临时创建的一个文件，有时间标记
      # 例如: /Users/jason/work/ruby-china/public/uploads/tmp/20131105-1057-46664-5614/_____2013-11-05___10.37.50.png
      @name ||= Digest::MD5.hexdigest(current_path)
      "#{@name}.#{file.extension}"
    end
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