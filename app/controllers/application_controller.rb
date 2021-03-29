class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :null_session

  private

  def crypt
    return @crypt if @crypt

    key = Rails.application.secrets.secret_key_base[0..31]
    @crypt ||= ActiveSupport::MessageEncryptor.new(key)
  end

  delegate :encrypt_and_sign, :decrypt_and_verify, to: :crypt
end
