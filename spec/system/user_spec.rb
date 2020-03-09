require 'rails_helper'

RSpec.describe 'ユーザー登録・ログイン・ログアウト機能' do
  before do
    FactoryBot.create(:user1)
    FactoryBot.create(:user2)
  end

  def login_admin
    visit new_session_path
    fill_in 'email', with: 'wasuretemouta5@gmai.com'
    fill_in 'session[password]', with: 'kazuyasu55'
    click_on 'login'
  end

  def login
    visit new_session_path
    fill_in 'email', with: 'wasuretemouta@gmai.com'
    fill_in 'session[password]', with: 'kazuyasu55'
    click_on 'login'
  end

  describe 'ユーザー登録テスト' do
    context 'ユーザー登録した場合' do
      it '自動でログインしてユーザーページに飛ぶ' do
        visit new_user_path
        fill_in 'user[name]', with: 'wasuretemouta7'
        fill_in 'user[email]', with: 'wasuretemouta7@gmai.com'
        fill_in 'user[password]', with: 'kazuyasu55'
        fill_in 'user[password_confirmation]', with: 'kazuyasu55'
        click_on '登録する'
        expect(page).to have_content 'wasuretemouta7さんのアカウントを作成しました'
        expect(page).to have_content 'ユーザーページ'
        expect(page).to have_content 'wasuretemouta7@gmai.com'
      end
    end

    # context 'メールアドレスの重複登録をしようとした場合' do
    #   it '登録済みのメールアドレスは登録出来ない' do
    #     visit new_user_path
    #     fill_in 'user[name]', with: 'wasuretemoutayone'
    #     fill_in 'user[email]', with: 'wasuretemouta5@gmai.com'
    #     fill_in 'user[password]', with: 'kazuyasu55'
    #     fill_in 'user[password_confirmation]', with: 'kazuyasu55'
    #     click_on '登録する'
    #     expect(page).to have_content 'Emailはすでに存在します'
    #   end
    # end
  end

  describe 'ログイン・ログアウト時テスト' do
    before do
      login_admin
    end

    context 'ログイン後、ログアウトした場合' do
      it '自動でユーザーページへ飛び、ログイン成功のメッセージが出る' do
        expect(page).to have_content 'ログインしました'
      end

      it 'ログアウトしましたと表示される' do
        visit tasks_path
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end

    context 'ログイン状態でユーザー登録画面へ遷移した場合' do
      it 'タスク一覧画面へ遷移する' do
        visit new_session_path
        expect(page).to have_content 'タスク一覧'
      end
    end
  end

  describe '複数ユーザーテスト' do
    before do
      login
    end

    context 'ログイン後、別ユーザー詳細ページに飛んだ場合' do
      it 'indexページへリダイレクトされる' do
        visit user_path(13)
        expect(page).to have_content 'タスク一覧'
      end
    end
  end

  describe '管理者権限テスト' do
    before do
      login_admin
    end

    context '管理者が一人しかいない状態で権限の変更をした場合' do
      it '権限の変更はできない' do
        visit edit_admin_user_path(4)
        select "public_user", from: 'user[admin]'
        fill_in 'user[password]', with: "kazuyasu55"
        fill_in 'user[password_confirmation]', with: "kazuyasu55"
        click_on "更新する"
        visit admin_user_path(4)
        expect(page).to have_content "administrator"
      end
    end
  end
end
