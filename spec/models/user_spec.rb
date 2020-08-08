require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end
  
  describe 'ユーザー登録' do
    context '名前とメールアドレスとパスワードが値として設定されている場合' do
      it 'このユーザーは登録可能である' do
        expect(@user).to be_valid
      end
    end
    
    describe 'ユーザーネームの文字数' do
      context '名前が20文字以下である場合' do
        it 'nameは登録可能である' do
          @user.name = 'a' * 20
          expect(@user).to be_valid
        end
      end
     
      context '名前が21文字以上である場合' do
        it 'nameのバリデーションが正常に機能する' do
          @user.name = 'a' * 21
          expect(@user).not_to be_valid
        end
      end
    end
    
    it '名前が空白であるとnameのバリデーションが正常に機能する' do
      @user.name = '' * 20
      expect(@user).not_to be_valid
    end
   
    it 'メールアドレスが空白であるとemailのバリデーションが正常に機能する' do
      @user.email = '' * 40
      expect(@user).not_to be_valid
    end

    it 'emailは小文字で保存されるべきである' do
      @user.email = 'Test@ExamPle.com'
      @user.save!
      expect(@user.reload.email).to eq 'test@example.com'
    end
    
    context '大文字と小文字を区別しない状態で重複するメールアドレスがある場合' do
      it 'emailの重複を許さないバリデーションが機能する' do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save!
        expect(duplicate_user).not_to be_valid
      end
    end
    
    describe '入力されるメールアドレスの形式' do
      context 'メールアドレスの形式が正しい場合' do
        it 'emailは登録可能である' do
          addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
          addresses.each do |valid_address|
            @user.email = valid_address
            expect(@user).to be_valid
          end
        end
      end
      
      context 'メールアドレスの形式が正しくない場合' do
        it 'emailのバリデーションが正常に機能する' do
          addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
          addresses.each do |invalid_address|
            @user.email = invalid_address
            expect(@user).not_to be_valid
          end
        end
      end
    end
    
    describe 'パスワードの文字数' do
      context 'パスワードが7文字の場合' do
        it 'passwordは正しい' do
          @user.password = @user.password_confirmation = 'a' * 7
          expect(@user).to be_valid
        end
      end
      
      context 'パスワードが6文字の場合' do
        it 'passwordのバリデーションが正常に機能する' do
          @user.password = @user.password_confirmation = 'a' * 6
          expect(@user).not_to be_valid
        end
      end
    end
  end
  
  describe 'マイプロフィール編集' do
    context '自己紹介文が300文字以内の場合' do
      it 'self_introductionは登録可能である' do
        @user.self_introduction = 'a' * 300
        expect(@user).to be_valid
      end
    end
    
    context '自己紹介文が301文字以上の場合' do
      it 'self_introductionのバリデーションが正常に機能する' do
        @user.self_introduction = 'a' * 301
        expect(@user).not_to be_valid
      end
    end
  end
end