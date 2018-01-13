class CompanyLogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_and_pad: [150, 150, :transparent, "Center"]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "fallback/default.png"
  end
end
