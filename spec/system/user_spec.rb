require 'rails_helper'

RSpec.describe 'ユーザー登録・ログイン・ログアウト機能' do
  before do
    FactoryBot.create(:user1)
    FactoryBot.create(:user2)
    # FactoryBot.create(:task, user_id: 1)
    # FactoryBot.create(:second_task, user_id: 2)
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
        sleep 1
        expect(page).to have_content 'wasuretemouta7さんのアカウントを作成しました'
        expect(page).to have_content 'ユーザーページ'
        expect(page).to have_content 'wasuretemouta7@gmai.com'
      end
    end

    context 'メールアドレスの重複登録をしようとした場合' do
      it '登録済みのメールアドレスは登録出来ない' do
        visit new_user_path
        fill_in 'user[name]', with: 'wasuretemoutayone'
        fill_in 'user[email]', with: 'wasuretemouta@gmai.com'
        fill_in 'user[password]', with: 'kazuyasu55'
        fill_in 'user[password_confirmation]', with: 'kazuyasu55'
        click_on '登録する'
        expect(page).to have_content 'Emailはすでに存在します'
        byebug
      end
    end
  end

  describe 'ログイン・ログアウト時テスト' do
    before do
      login_admin
    end

    context 'ログイン後、ログアウトした場合' do
      it '自動でユーザーページへ飛び、ログイン成功のメッセージが出る' do
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content 'wasuretemouta7@gmai.com'
        byebug
      end
    end

    #   it 'ログアウトしましたと表示される' do
    #     visit tasks_path
    #     click_on 'ログアウト'
    #     expect(page).to have_content 'ログアウトしました'
    #   end
    # end

    context 'ログアウト状態でタスクページに飛ぼうとした場合' do
      it 'ログインページへする' do
        click_on 'ログアウト'
        visit tasks_path
        expect(page).to have_content 'ログインページ'
      end
    end
  end
  #
  #   context 'ログイン状態でユーザー登録画面へ遷移した場合' do
  #     it 'タスク一覧画面へ遷移する' do
  #       visit new_session_path
  #       expect(page).to have_content 'タスク一覧'
  #     end
  #   end
  # end

  describe '複数ユーザーテスト' do
    before do
      login
    end
  end

  #   context 'ログイン後、別ユーザー詳細ページに飛んだ場合' do
  #     it 'indexページへリダイレクトされる' do
  #       visit user_path(13)
  #       expect(page).to have_content 'タスク一覧'
  #     end
  #   end
  # end

  describe '管理者権限テスト' do
    before do
      login_admin
    end

    context '管理者権限でログインした場合' do
      it '管理者自身のアカウント削除は出来ない' do
        visit admin_users_path
        page.all('td')[4].click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "管理者自身は削除できません"
        byebug
      end

      it 'ユーザー管理画面に遷移できる' do
        click_on "ユーザー管理"
        expect(page).to have_content "管理画面のユーザー一覧"
      end

      it 'ユーザー情報の更新ができる' do
        visit edit_admin_user_path(1)
        select "administrator", from: 'user[admin]'
        fill_in 'user[password]', with: "kazuyasu55"
        fill_in 'user[password_confirmation]', with: "kazuyasu55"
        click_on "更新する"
        expect(page).to have_content "ユーザー【 test1 】の更新をしました"
        byebug
      end
    end

    context '管理者が一人しかいない状態で権限の変更をした場合' do
      # it '権限の変更はできない' do
      #   visit edit_admin_user_path(4)
      #   select "public_user", from: 'user[admin]'
      #   fill_in 'user[password]', with: "kazuyasu55"
      #   fill_in 'user[password_confirmation]', with: "kazuyasu55"
      #   click_on "更新する"
      #   visit admin_user_path(4)
      #   expect(page).to have_content "administrator"
      # end

      it 'エラーメッセージが出る' do
        visit edit_admin_user_path(4)
        select "public_user", from: 'user[admin]'
        fill_in 'user[password]', with: "kazuyasu55"
        fill_in 'user[password_confirmation]', with: "kazuyasu55"
        click_on "更新する"
        expect(page).to have_content "ユーザー【 test1 】の権限以外を更新しました　※管理者は最低一人必要です"
        byebug
      end
    end
  end
end




# require 'rails_helper'
#
# RSpec.describe User, type: :system do
#
#   before do
#     FactoryBot.create(:user)
#   end
#
#   describe 'ログイン画面' do
#     context 'ログインした場合' do
#       it 'マイページに変遷されること' do
#         visit sessions_new_url
#         fill_in 'email', with: 'wasuretemouta4@gmai.com'
#         fill_in 'session[password]', with: 'banzai12345'
#         click_on 'login'
#         expect(page).to have_content 'テストユーザー１'
#       end
#     end
#   end
#
#   describe 'ログインしていない状態' do
#     context 'タスク一覧ページへ移行する場合' do
#       it "ログイン画面へリダイレクトされること" do
#         visit sessions_new_url
#         fill_in 'email', with: 'wasuretemouta4@gmai.com'
#         fill_in 'session[password]', with: 'banzai12345'
#         click_on 'login'
#         click_on 'ログアウト'
#         # debugger
#         visit sessions_new_url
#         expect(page).to have_content 'ログインしてください'
#       end
#     end
#   end
#
#   describe 'ログインしている状態' do
#     context 'タスク一覧ページへ移行した場合' do
#       it "自分が作成したタスクのみが表示されていること" do
#         FactoryBot.create(:user, id: 2, email: "wasuretemouta6@gmai.com")
#
#         FactoryBot.create(:task,
#                           title: "テストユーザー１作成タスクタイトル",
#                           content: 'テストユーザー１作成タスクコンテンツ',
#                           user_id: 1)
#
#         FactoryBot.create(:task,
#                           id: 2,
#                           title: "テストユーザー２作成タスクタイトル",
#                           content: 'テストユーザー２作成タスクコンテンツ',
#                           user_id: 2)
#
#         visit sessions_new_url
#         fill_in 'email', with: 'wasuretemouta6@gmai.com'
#         fill_in 'session[password]', with: 'banzai12345'
#         click_on 'Tasks_index'
#         debugger
#         visit tasks_path
#         expect(page).to_not have_content 'テストユーザー２作成タスクコンテンツ'
#       end
#     end
#   end
#
#   describe 'ログインしている状態' do
#     context '再度ログインする場合' do
#       it "マイページへリダイレクトされること" do
#         visit sessions_new_url
#         fill_in 'email', with: 'wasuretemouta6@gmai.com'
#         fill_in 'session[password]', with: 'banzai12345'
#         click_on 'login'
#         debugger
#         visit sessions_new_url
#         expect(page).to have_content 'すでにログインしています'
#       end
#     end
#   end
#
#   describe 'ログインしている状態' do
#     context '自分以外のユーザーのページに移行するとき' do
#       it "マイページへリダイレクトされること" do
#         FactoryBot.create(:user, id: 2, email: "wasuretemouta6@gmai.com")
#         visit sessions_new_url
#         fill_in 'email', with: 'wasuretemouta6@gmai.com'
#         fill_in 'session[password]', with: 'banzai12345'
#         click_on 'login'
#         debugger
#         visit user_path(2)
#         expect(page).to have_content 'ユーザーが違います'
#       end
#     end
#   end
#
#   end
