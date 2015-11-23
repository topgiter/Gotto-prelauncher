module Tokened

  extend ActiveSupport::Concern

  included do
    after_initialize do
      self.token = generate_token if self.token.blank?
    end
  end

  private
    def generate_token
      loop do
        key = SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
        break key unless self.class.find_by(token: key)
      end
    end
end