FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title' }
    content { 'test_content' }
    deadline { "2020-01-02" }
    priority { "test_priority" }
    status { "test_status" }
  end

  factory :new_task, class: Task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title2' }
    content { 'test_content2' }
    deadline { "2020-01-02" }
    priority { "test_priority2" }
    status { "test_status2" }
  end
end
