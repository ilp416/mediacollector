class UrlStuff < Stuff

  has_attached_file :screenshot,
    styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/missing_images/:style/url.png",
    preserve_files: false
  validates_attachment_content_type :screenshot, content_type: /\Aimage\/.*\Z/

  validates_presence_of :target_url

  after_create :get_screenshot
  require 'screenshot_machine'
  require 'tempfile'

  def get_screenshot
    return if Rails.env.test?
    Thread.new do
      data = ScreenshotMachine.new(target_url).screenshot
      tmp = Tempfile.new('screenshot').binmode
      tmp.write(data)
      self.screenshot = tmp
      tmp.close && tmp.unlink
      save
    end
  end
end
