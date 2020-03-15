FactoryBot.define do
  factory :label do
    label_type { 'お仕事' }
    user
  end

  factory :second_label, class: Label do
    label_type { 'プライベート' }
    user
    # association :user, factory: :admin_user
  end

end
