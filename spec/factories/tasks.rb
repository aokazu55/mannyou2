FactoryBot.define do
  factory :task, class: Task do
    title { 'test_task' }
    content { 'test_content' }
    priority { '高' }
    status { '未着手' }
    deadline { "2022-03-09" }
  end

  factory :second_task, class: Task do
    title { 'test_task2' }
    content { 'test_content2' }
    priority { '中' }
    status { '着手中' }
    deadline { "2022-01-05" }
  end

  factory :third_task, class: Task do
    title { 'test_task3' }
    content { 'test_content3' }
    priority { '中' }
    status { '着手中' }
    deadline { "2022-12-09" }
  end

  factory :search_task_01, class: Task do
    title { '検索' }
    content { '検索' }
    priority { '高' }
    status { '未着手' }
    deadline { "2021-03-09" }
  end

  factory :search_task_02, class: Task do
    title { '検索' }
    content { 'ケンサク' }
    priority { '高' }
    status { '未着手' }
    deadline { "2025-03-18" }
  end

  factory :search_task_03, class: Task do
    title { 'けんさく' }
    content { 'けんさく' }
    priority { '低' }
    status { '完了' }
    deadline { "2024-03-26" }
  end
end
