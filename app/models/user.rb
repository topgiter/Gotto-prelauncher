class User < ActiveRecord::Base
  belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"
  has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"  
  attr_accessible :email

  validates :email, :uniqueness => true, :format => { :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i, :message => "Invalid email format." }
  validates :referral_code, :uniqueness => true

  before_create :create_referral_code
  after_create :send_welcome_email

  # user = User.create
  # user.token1 => "asd"

  REFERRAL_STEPS = [
    {
      'count' => 7,
      "html" => "Free Grotto Hour",
      "class" => "two"
      # "image" =>  ActionController::Base.helpers.asset_path("home/pit_1.png")
    },
    {
      'count' => 15,
      "html" => "Free Grotto Hour<br>For You And 3 Friends",
      "class" => "three"
      # "image" => ActionController::Base.helpers.asset_path("home/pit_truggle.png")
    },
    {
      'count' => 25,
      "html" => "Free Grotto<br>For A Month",
      "class" => "four"
      # "image" => ActionController::Base.helpers.asset_path("home/pit_stuggle_fast.png")
    }
    
  ]

  # def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     user.save!
  #   end
  # end
  
  private

  def create_referral_code
    referral_code = SecureRandom.hex(5)
    @collision = User.find_by_referral_code(referral_code)

    while !@collision.nil?
      referral_code = SecureRandom.hex(5)
      @collision = User.find_by_referral_code(referral_code)
    end

    self.referral_code = referral_code
  end

  def send_welcome_email
    UserMailer.delay.signup_email(self)
  end
end
