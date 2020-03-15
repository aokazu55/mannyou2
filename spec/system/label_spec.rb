require 'rails_helper'

RSpec.describe 'ラベル作成と登録機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label_1) { FactoryBot.create(:label, user: user) }
  let!(:label_2) { FactoryBot.create(:second_label, user: user) }

  before do
    visit new_session_path
    fill_in 'email', with: 'wasuretemouta1@gmai.com'
    fill_in 'Password', with: 'kazuyasu55'
    click_on 'login'
    expect(page).to have_content 'wasuretemouta1'
  end

  describe 'ラベル作成画面' do
    context '必要項目を入力して、登録するボタンを押した場合' do
      it 'データ保存後、タスク一覧に表示されること' do
        visit new_label_path
        fill_in 'label[label_type]', with: 'お仕事'
        click_on '登録する'
        # byebug
        task_list = page.all('tr')
        expect(task_list[1]).to have_content 'お仕事'
      end

      it '空白のラベルは作成できないこと' do
        visit new_label_path
        click_on '登録する'
        expect(page).to have_content 'ラベル名を決めてください'
      end
    end
  end

  describe 'タスク一覧・詳細画面' do
    context 'タスク登録' do
      it "タスク登録時に既存のラベルを選択し、作成タスクに紐づけることができること" do
        visit new_task_path
        fill_in 'task_title', with: 'test_title'
        fill_in 'task_content', with: 'test_content'
        fill_in 'task_deadline', with: Date.new(2020, 11 ,30)
        select "高", from: "task_priority"
        select "未着手", from: "task_status"
        check "task_label_ids_#{label_1.id}"
        # byebug
        click_on '登録する'
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
        expect(page).to have_content '2020-11-30'
        expect(page).to have_content "高"
        expect(page).to have_content "未着手"
      end

      it "タスク詳細画面で関連づけたラベルが一覧で表示されること" do
        visit new_task_path
        fill_in 'task_title', with: 'test_title'
        fill_in 'task_content', with: 'test_content'
        fill_in 'task_deadline', with: Date.new(2020, 11 ,30)
        select "高", from: "task_priority"
        select "未着手", from: "task_status"
        check "task_label_ids_#{label_1.id}"
        click_button '登録する'
        # byebug
        expect(page).to have_content 'test_title'
        expect(page).not_to have_content 'test_title55'
      end
    end
  end
end
