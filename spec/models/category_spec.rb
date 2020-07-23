require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @category = build(:category)
  end
  
  it '名前が空白であるとnameのバリデーションが正常に機能する' do
    @category.name = ''
    expect(@category).not_to be_valid
  end
end
