
FactoryBot.define do
  factory :user1, class: User do
    id { 10 }
    name { 'wasuretemouta' }
    email { 'wasuretemouta@gmai.com' }
    password { 'kazuyasu55' }
    password_confirmation { 'kazuyasu55' }
    admin { false }
  end

  factory :user2, class: User do
    id { 4 }
    name { 'wasuretemouta5' }
    email { 'wasuretemouta5@gmai.com' }
    password { 'kazuyasu55' }
    password_confirmation { 'kazuyasu55' }
    admin { true }
  end
end
#   factory :user3, class: User do
#     id { 30 }
#     name { 'test3' }
#     email { 'test3@a.com' }
#     password { 'hogehoge' }
#     admin { false }
#   end
# end

# FactoryBot.define do
#   factory :user do
#     id { 1 }
#     name { "テストユーザー１" }
#     email { "wasuretemouta4@gmai.com" }
#     password { "banzai12345" }
#     password_confirmation { "banzai12345" }
#     admin { false }
#   end
# end
