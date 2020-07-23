require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = create(:user)
    category = create(:category)
    area = create(:area)
    @item = build(:item, user_id: user.id, category_id: category.id, area_id: area.id)
  end
  
  describe 'アイテム登録' do
    context '名前と画像とアイテム説明とカテゴリーと地域が値として設定されている場合' do
      it 'このアイテムは登録可能である' do
        expect(@item).to be_valid
      end
    end
    
    describe 'アイテム名の文字数' do
      context '名前が40文字以下である場合' do
        it 'nameは登録可能である' do
          @item.name = 'a' * 40
          expect(@item).to be_valid
        end
      end
     
      context '名前が41文字以上である場合' do
        it 'nameのバリデーションが正常に機能する' do
          @item.name = 'a' * 41
          expect(@item).not_to be_valid
        end
      end
    end
    
    it '名前が空白であるとnameのバリデーションが正常に機能する' do
      @item.name = '' * 40
      expect(@item).not_to be_valid
    end
    
    it '画像が空白であるとimageのバリデーションが正常に機能する' do
      @item.image = ''
      expect(@item).not_to be_valid
    end
    
    describe 'アイテム説明の文字数' do
      context 'アイテム説明が300文字以内の場合' do
        it 'explanationは登録可能である' do
          @item.explanation = 'a' * 300
          expect(@item).to be_valid
        end
      end
      
      context 'アイテム説明が301文字以上の場合' do
        it 'explanationのバリデーションが正常に機能する' do
          @item.explanation = 'a' * 301
          expect(@item).not_to be_valid
        end
      end
    end
    
    it 'アイテム説明が空白であるとexplanationのバリデーションが正常に機能する' do
      @item.explanation = ''
      expect(@item).not_to be_valid
    end
    
    it 'カテゴリーが空白であるとcategory_idのバリデーションが正常に機能する' do
      @item.category_id = ''
      expect(@item).not_to be_valid
    end
    
    it '地域が空白であるとarea_idのバリデーションが正常に機能する' do
      @item.area_id = ''
      expect(@item).not_to be_valid
    end
  end
end
