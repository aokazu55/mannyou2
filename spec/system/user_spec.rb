require 'rails_helper'

RSpec.describe 'ユーザー登録・ログイン・ログアウト機能' do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:admin_user)
  end

  def login_admin
    visit new_session_path
    fill_in 'email', with: 'wasuretemouta2@gmai.com'
    fill_in 'session[password]', with: 'kazuyasu55'
    click_on 'login'
  end

  def login
    visit new_session_path
    fill_in 'email', with: 'wasuretemouta1@gmai.com'
    fill_in 'session[password]', with: 'kazuyasu55'
    click_on 'login'
  end

  describe 'ユーザー登録テスト' do
    context 'メールアドレスの重複登録をしようとした場合' do
      it '登録済みのメールアドレスは登録出来ない' do
        visit new_user_path
        fill_in 'user[name]', with: 'wasuretemoutayone'
        fill_in 'user[email]', with: 'wasuretemouta1@gmai.com'
        fill_in 'user[password]', with: 'kazuyasu55'
        fill_in 'user[password_confirmation]', with: 'kazuyasu55'
        click_on '登録する'
        expect(page).to have_content 'メールアドレスはすでに存在します'
        # byebug
      end
    end
  end

  describe 'ログイン・ログアウト時テスト' do
    before do
      login
    end

    context 'ログイン後、ログアウトした場合' do
      it '自動でユーザーページへ飛び、ログイン成功のメッセージが出る' do
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content 'wasuretemouta1@gmai.com'
        # byebug
      end

      it 'ログアウトしましたと表示される' do
        visit tasks_path
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        # byebug
      end
    end

    context 'ログイン状態でユーザー登録画面へ遷移した場合' do
      it 'タスク一覧画面へ遷移する' do
        visit tasks_path
        expect(page).to have_content 'タスク一覧'
      end
    end
  end

  describe '管理者権限テスト' do
    before do
      login_admin
    end

    context '管理者権限でログインした場合' do
      it 'ユーザー管理画面に遷移できる' do
        click_on "ユーザー管理"
        visit admin_users_path
        expect(page).to have_content "Administrator_View"
      end

      it 'ユーザー情報の更新ができる' do
        visit edit_admin_user_path(2)
        select "administrator", from: 'user[admin]'
        fill_in 'user[password]', with: "kazuyasu55"
        fill_in 'user[password_confirmation]', with: "kazuyasu55"
        click_on "更新する"
        # visit admin_users_path
        expect(page).to have_content "ユーザー【 wasuretemouta2 】の更新をしました"
        # byebug
      end
    end

    context '管理者が一人しかいない状態で権限の変更をした場合' do
      it '権限の変更はできない' do
        visit edit_admin_user_path(2)
        select "public_user", from: 'user[admin]'
        fill_in 'user[password]', with: "kazuyasu55"
        fill_in 'user[password_confirmation]', with: "kazuyasu55"
        click_on "更新する"
        expect(page).to have_content "ユーザー【 wasuretemouta2 】の権限以外を更新しました　※管理者は最低一人必要です"
      end
    end
  end
end
