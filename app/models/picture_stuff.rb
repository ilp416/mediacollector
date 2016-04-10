class PictureStuff < Stuff
  has_attached_file :picture,
    styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/missing_images/:style/picture.png",
    preserve_files: false
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  validates_presence_of :picture
end
