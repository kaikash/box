class Uploader < CarrierWave::Uploader::Base
# include CarrierWave::RMagick
  storage :file

  def store_dir
	"img/"
  end

  def filename
	"#{secure}#{extension}" if original_filename.present?
  end

  def extension_white_list
	%w(png gif bmp jpg)
  end
  private
	def secure
    SecureRandom.hex 10
	end

	def extension
		File.extname original_filename
	end
end