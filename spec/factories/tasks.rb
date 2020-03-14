FactoryBot.define do
  factory :task do
    title { 'test_task' }
    content { 'test_content' }
    priority { '高' }
    status { '未着手' }
    deadline { "2022-03-09" }
    user
  end

  factory :second_task, class: Task do
    title { 'test_task2' }
    content { 'test_content2' }
    priority { '中' }
    status { '着手中' }
    deadline { "2022-01-05" }
    user
  end

  factory :third_task, class: Task do
    title { 'test_task3' }
    content { 'test_content3' }
    priority { '中' }
    status { '着手中' }
    deadline { "2022-12-09" }
    user
  end
end
