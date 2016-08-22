class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable

  validates :username,
            presence: true,
            uniqueness: {
                case_sensitive: false
            },
            length: { maximum: 30, too_long: '%{count} characters is the maximum allowed' }

  validates :password, length: { minimum: 6,
                                 maximum: 50,
                                 too_long: '%{count} characters is the maximum allowed',
                                 too_short: 'minimum %{count} characters is allowed' }

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
end
