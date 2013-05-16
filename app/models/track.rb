class Track < ActiveRecord::Base
  attr_accessible :title, :track_file, :artist

  mount_uploader :track_file, TrackUploader
end
