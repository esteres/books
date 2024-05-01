require 'rails_helper'

describe AuthenticationTokenService do
  describe '.call' do
    let(:user_id) { 1 }
    let(:token) { described_class.call(user_id) }

    it 'returns an autentication token' do
      decoded_token = JWT.decode(
        token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHM_TYPE }
      )
      expect(decoded_token).to eq(
        [
          { 'user_id' => user_id },
          { 'alg' => 'HS256' }
        ]
      )
    end
  end
end
