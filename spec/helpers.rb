module Helpers
  def build_jar(request, cookies)
    ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
  end

  def crypt
    return @crypt if @crypt

    key = Rails.application.credentials.secret_key_base[0..31]
    @crypt ||= ActiveSupport::MessageEncryptor.new(key)
  end

  delegate :encrypt_and_sign, :decrypt_and_verify, to: :crypt
end
