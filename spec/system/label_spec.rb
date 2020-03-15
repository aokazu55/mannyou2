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
        fill_in 'label[label_type]', with: '緊急'
        click_on '登録する'
        # byebug
        task_list = page.all('tr')
        expect(task_list[1]).to have_content '緊急'
      end

      it '空白のラベルは作成できないこと' do
        visit new_label_path
        click_on '登録する'
        expect(page).to have_content 'ラベル名を決めてください'
      end
    end
  end

  describe 'タスク一覧・詳細画面' do
    context 'ラベル付タスクを作成した場合' do
      it 'タスク一覧にラベルが表示されること' do
        visit tasks_path
        expect(page).to have_content '緊急'
        expect(page).to have_content 'しなやかに'
        expect(page).not_to have_content 'お仕事'
      end

      it 'タスク詳細にラベルが表示されること' do
        visit task_path(1)
        expect(page).to have_content '緊急'
      end
    end
  end

  describe 'タスク一覧画面' do
    context '検索機能' do
      it 'ラベルで絞り込み検索できること' do
        visit tasks_path
        select '緊急', from: 'task[label_ids]'
        click_on '検索はコチラ'
        # byebug
        task_list = page.all('tr')
        expect(task_list[1]).to have_content '緊急'
        expect(task_list).not_to have_content 'しなやかに'
      end

      it '他ユーザーのラベル（タスク）が出てこないこと' do
        visit tasks_path
        select '緊急', from: 'task[label_ids]'
        click_on '検索はコチラ'
        # byebug
        task_list = page.all('tr')
        expect(task_list[1]).to have_content '緊急'
        expect(task_list[1]).not_to have_content 'しなやかに'
      end
    end
  end
end
