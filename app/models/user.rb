class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stuffs

  before_validation :set_nickname

  validates_length_of :nickname, :minimum => 6
  validates_format_of :nickname, with: /[A-Za-z]/
  validates_uniqueness_of :email, :nickname, :case_sensitive => false

  def nickname_uniq?
    User.where(nickname: nickname).where.not(id: id).empty?
  end

  def set_nickname
    return if email.blank?
    while nickname.blank? || !nickname_uniq?
      self.nickname = email[0..(email =~ /@/)-1] + rand(36**7).to_s(36)
    end
  end

  def to_param
    nickname
  end
end
