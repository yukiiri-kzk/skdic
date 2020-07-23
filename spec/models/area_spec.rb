require 'rails_helper'

RSpec.describe Area, type: :model do
  before do
    @area = build(:area)
  end
  
  it '名前が空白であるとnameのバリデーションが正常に機能する' do
    @area.name = ''
    expect(@area).not_to be_valid
  end
end
