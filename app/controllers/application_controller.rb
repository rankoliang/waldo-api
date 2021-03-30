class ApplicationController < ActionController::API
  private

  def crypt
    return @crypt if @crypt

    key = Rails.application.secrets.secret_key_base[0..31]
    @crypt ||= ActiveSupport::MessageEncryptor.new(key)
  end

  delegate :encrypt_and_sign, :decrypt_and_verify, to: :crypt

  def update_token(token)
    data = decrypt_and_verify(token)

    yield(data)

    encrypt_and_sign(data)
  rescue ActiveSupport::MessageEncryptor::InvalidMessage
    render json: { error: 'The token is invalid.', status: :bad_request }
  end
end
