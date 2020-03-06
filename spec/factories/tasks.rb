FactoryBot.define do
  factory :task, class: Task do
    title { 'test_task' }
    content { 'test_content' }
    priority { '高' }
    status { '未着手' }
    deadline { "2022-03-09" }
    # user_id { 10 }
  end

  factory :second_task, class: Task do
    title { 'test_task2' }
    content { 'test_content2' }
    priority { '中' }
    status { '着手中' }
    deadline { "2022-01-05" }
    # user_id { 10 }
  end

  factory :third_task, class: Task do
    title { 'test_task2' }
    content { 'test_content2' }
    priority { '中' }
    status { '着手中' }
    deadline { "2022-12-09" }
    # user_id { 20 }
  end

  factory :search_task_01, class: Task do
    title { '検索' }
    content { '検索' }
    priority { '低' }
    status { '未着手' }
    deadline { "2021-10-09" }
    # user_id { 20 }
  end

  factory :search_task_02, class: Task do
    title { 'ケンサク' }
    content { 'ケンサク' }
    priority { '高' }
    status { '未着手' }
    deadline { "2025-03-18" }
    # user_id { 20 }
  end

  factory :search_task_03, class: Task do
    title { 'けんさく' }
    content { 'けんさく' }
    priority { '低' }
    status { '完了' }
    deadline { "2024-03-26" }
    # user_id { 30 }
  end
end

# FactoryBot.define do
#   factory :task do
#     # 下記の内容は実際に作成するカラム名に合わせて変更してください
#     title { 'test_title' }
#     content { 'test_content' }
#     deadline { "2020-01-02" }
#     priority { "test_priority" }
#     status { "test_status" }
#   end
#
#   factory :new_task, class: Task do
#     # 下記の内容は実際に作成するカラム名に合わせて変更してください
#     title { 'test_title2' }
#     content { 'test_content2' }
#     deadline { "2020-01-02" }
#     priority { "test_priority2" }
#     status { "test_status2" }
#   end
# end
