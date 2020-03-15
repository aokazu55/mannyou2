FactoryBot.define do
  factory :label do
    label_type { '緊急' }
    user
  end

  factory :second_label, class: Label do
    label_type { 'しなやかに' }
    user
    # association :user, factory: :admin_user
  end

end
