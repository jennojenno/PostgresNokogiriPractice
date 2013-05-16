# encoding: utf-8

class TrackUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :guess_track
  def guess_track
    #binding.pry
    result = JSON.parse(`echoprint-codegen #{path}`)
    model.title = result.first["metadata"]["title"]
    model.artist = result.first["metadata"]["artist"]
    artistspacefix = model.artist.gsub(" ", "%20")

    #rightartist = Echonest::Artist.new('Y3MG2UKAVGMYL8XPT', model.artist)
    #findartistid = "http://developer.echonest.com/api/v4/artist/search?api_key=Y3MG2UKAVGMYL8XPT&name=#{rightartist}"
    #artistidresults = HTTParty.get(findartistid)
    #binding.pry

    url = "http://developer.echonest.com/api/v4/artist/similar?api_key=Y3MG2UKAVGMYL8XPT&name=#{artistspacefix}&format=json&results=3&start=0"
    results = HTTParty.get(url)
    #binding.pry
    model.wrong_answer_1, model.wrong_answer_2, model.wrong_answer_3 = results["response"]["artists"].sample(3).map! {|a| a["name"]}
  end 

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
