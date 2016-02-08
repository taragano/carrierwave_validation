class Post < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	validate :max_dimensions
	after_save :clear_cache

  def max_dimensions
  	max_width = 1000
  	width, height = ::MiniMagick::Image.open(image.file.path)[:dimensions]
    if width > max_width
      errors.add(:image, ": You cannot upload an image larger than #{max_width} pixels")
    end
  end

  def clear_cache
		CarrierWave.clean_cached_files! 0
  end
end