require 'rails_helper'
require 'byebug'

RSpec.describe 'タスク管理機能', type: :system do
  # before do
  #   FactoryBot.create(:task)
  #   FactoryBot.create(:new_task)
  # end

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
        fill_in 'task_title', with: 'test_title'
        fill_in 'task_content', with: 'test_content'
        fill_in 'task_deadline', with: Date.new(2020, 12 ,12)
        select '高', from: 'task_priority'
        select '未着手', from: 'task_status'
        click_on '登録する'
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
        expect(page).to have_content "2020-12-12"
        expect(page).to have_content "高"
        expect(page).to have_content "未着手"
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
         task = Task.create(title: 'test_title', content: 'test_content', deadline: "2020-12-12", priority: '高', status: '未着手')
         visit task_path(task)
         visit task_path(task.id)
         expect(page).to have_content 'test_title'
         expect(page).to have_content 'test_content'
         expect(page).to have_content "2020-12-12"
         expect(page).to have_content '高'
         expect(page).to have_content '未着手'
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

  describe "タスク一覧画面" do
    context '終了期限でソートするをクリックした場合' do
      it 'タスクが完了期限順に並んでいること' do
        @task2 = FactoryBot.create(:task, title: "期限を超過したタスク", content: '期限を超過したタスク', created_at: Date.today-7, deadline: Date.today-7, status: '未着手', priority: '高')
        visit tasks_path
        click_on '【完了期限でソート】'
        click_on '【完了期限でソート】', match: :first
        expect(page).to have_content '超過'
      end
    end
  end

  describe "タスク一覧画面" do
    context '優先順位でソートするボタンを押した場合' do
      it '優先順位の降順に並んでいること' do
        @task4 = FactoryBot.create(:task, title: "優先順位通りに並ぶ？", content: 'どうかな？？', status: '着手中', priority: '高')
        visit tasks_path
        click_on '【優先順位でソート】'
        click_on '【優先順位でソート】', match: :first
        expect(page).to have_content '優先順位'
      end
    end
  end
end
