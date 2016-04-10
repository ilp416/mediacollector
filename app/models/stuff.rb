class Stuff < ActiveRecord::Base
  belongs_to :user
  after_initialize :set_default_type

  validates_presence_of :user, :type

  def set_default_type
    self.type ||= 'UrlStuff'
  end

end
