FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'wasuretemouta1' }
    email { 'wasuretemouta1@gmai.com' }
    password { 'kazuyasu55' }
    admin { false }
  end

  factory :admin_user, class: User do
    id { 2 }
    name { 'wasuretemouta2' }
    email { 'wasuretemouta2@gmai.com' }
    password { 'kazuyasu55' }
    admin { true }
  end
end
