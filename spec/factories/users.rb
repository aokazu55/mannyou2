
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
