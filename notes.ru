describe 'callbacks' do
    it { is_expected.to callback(:create_notification).after(:create) }
 end