status_list = ["未着手","着手中","完了"]
label_list = ["お仕事","プライベート","なるはや"]
#user
(1..3).each do |n|
  user = User.create(name: "user#{n}", email: "user#{n}_mail@sample.com", password: 'sampletest', admin: false )
  admin = User.create(name: "admin#{n}", email: "admin#{n}_mail@sample.com", password: 'sampletest', admin: true )
#task
  task_user = Task.create(title: "seed_title#{n}", content:"これはシードデータ#{n}件目です。", deadline:"2021-#{n}-01", status:status_list[n], priority: n-1, user: user)
  task_admin = Task.create(title: "seed_title#{n}", content:"これはシードデータ#{n}件目です。", deadline:"2021-#{n}-01", status:status_list[n], priority: n-1, user: admin)
#label
  label = Label.create(label_type: label_list[n-1])
end
