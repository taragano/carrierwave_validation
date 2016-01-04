class Post < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	validate :max_dimensions

  def max_dimensions
  	max_width = 1000
  	width, height = ::MiniMagick::Image.open(image.file.path)[:dimensions]
    if width > max_width
      errors.add(:image, ": You cannot upload an image larger than #{max_width} pixels")
    end
  end
end
