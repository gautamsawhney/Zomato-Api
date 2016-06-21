FactoryGirl.define do
  factory :authtoken do
    token "MyString"
    last_used_at "2016-06-21 07:55:46"
    sign_in_ip ""
    user_agent "MyString"
    device_id "MyString"
    user 
  end
end
