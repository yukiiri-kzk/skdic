require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = build(:message)
  end
  
  describe 'メッセージ投稿' do
    it 'コンテンツが301文字以上であるとcontentのバリデーションが正常に機能する' do
      @message.content = 'a' * 301
      expect(@message).not_to be_valid
    end
    
    it 'コンテンツが空白であるとcontentのバリデーションが正常に機能する' do
      @message.content = '' * 300
      expect(@message).not_to be_valid
    end
  end
end
