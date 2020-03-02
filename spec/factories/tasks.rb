FactoryBot.define do
  factory :task do
    title { "MyString" }
    content { "MyText" }
    deadline { "2020-03-02" }
    priority { "MyString" }
    status { "MyString" }
    user_id { 1 }
  end
end
