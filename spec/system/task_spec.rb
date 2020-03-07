require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:search_task_03)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        visit tasks_path
        expect(page).to have_content 'test_task'
        expect(page).to have_content 'test_content'
        expect(page).to have_content '高'
        expect(page).to have_content '未着手'
        expect(page).to have_content '2022-03-09'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        visit tasks_path
        task_list = page.all('tr')
        expect(task_list[1]).to have_content 'task'
      end
    end

    context '【完了期限でソート】をクリックした場合' do
      it 'タスクが完了期限順に並んでいること' do
        @task2 = FactoryBot.create(:task, title: "期限を超過したタスク", content: '期限を超過したタスク', created_at: Date.today-7, deadline: Date.today-7, status: '未着手', priority: '高')
        visit tasks_path
        click_on '【完了期限でソート】'
        click_on '【完了期限でソート】', match: :first
        expect(page).to have_content '超過'
      end
    end
  end

  describe 'ソート・検索機能' do
    context '検索・ソート機能' do
      it 'タイトルのみの検索結果が出ること' do
        visit tasks_path
        fill_in 'task[title]', with: 'test_task'
        click_on '検索はコチラ'
        title = page.all('tr')
        expect(title[1]).to have_content 'test_task'
        expect(title[2]).not_to have_content 'テストけんさく'
      end

      it 'ステータスのみ検索結果に出ること' do
        visit tasks_path
        select '未着手', from: 'task[status]'
        click_on '検索はコチラ'
        title = page.all('tr')
        expect(title[1]).to have_content '未着手'
        expect(title[2]).to have_content ''
      end

      it 'タイトル・ステータス共に検索して1件' do
        visit tasks_path
        fill_in 'task[title]', with: 'task'
        click_on '検索はコチラ'
        select '着手中', from: 'task[status]'
        click_on '検索はコチラ'
        title = page.all('tr')
        expect(title[1]).to have_content 'test_task2', '着手中'
        expect(title[2]).to have_content ''
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'task_title', with: 'test_title'
        fill_in 'task_content', with: 'test_content'
        fill_in 'task_deadline', with: Date.new(2020, 11 ,30)
        select "高", from: "task_priority"
        select "未着手", from: "task_status"
        click_on '登録する'
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
        expect(page).to have_content '2020-11-30'
        expect(page).to have_content "高"
        expect(page).to have_content "未着手"
      end
    end
  end
end
