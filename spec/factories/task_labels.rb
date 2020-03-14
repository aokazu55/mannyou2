FactoryBot.define do
  factory :task_label do
    association :task, factory: :task
    association :label, factory: :label
  end

  factory :second_task_label, class: TaskLabel do
    association :task, factory: :second_task
    association :label, factory: :second_label
  end
end
