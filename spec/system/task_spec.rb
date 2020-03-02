equire 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:new_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'task_title', with: 'test-title'
        fill_in 'task_content', with: 'test-content'
        fill_in 'task_deadline', with: Date.new(2020, 12 ,12)
        fill_in 'task_priority', with: 'test-priority'
        click_on '登録する'
        expect(page).to have_content 'test-title'
        expect(page).to have_content 'test-content'
        expect(page).to have_content "2020-12-12"
        expect(page).to have_content 'test-priority'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
         task = Task.create(id: 3, title: 'test-title', content: 'test-content', deadline: "2020-12-12", priority: 'test-priority')
         visit task_path(task)
         visit task_path(task.id)
         expect(page).to have_content 'test-title'
         expect(page).to have_content 'test-content'
         expect(page).to have_content "2020-12-12"
         expect(page).to have_content 'test-priority'
       end
     end
  end

  describe 'タスク一覧画面' do
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        new_task = FactoryBot.create(:task, title: 'new_task')
        visit tasks_path
        task_list = page.all('tr')
        expect(task_list[1]).to have_content 'new_task'
      end
    end
  end
end
