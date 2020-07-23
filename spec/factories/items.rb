FactoryBot.define do
  factory :item do
    name {'テストアイテム'}
    explanation {'テスト用のアイテムです。'}
    image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/default.png'))}
  end
end
