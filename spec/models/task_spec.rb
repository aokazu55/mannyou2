require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  before do
    # FactoryBot.create(:user1)
    # FactoryBot.create(:user2)
    # FactoryBot.create(:user3)
    FactoryBot.create(:search_task_01)
    FactoryBot.create(:search_task_02)
    FactoryBot.create(:search_task_03)
    @blank_title = FactoryBot.build(:task, title: "")
    @blank_content = FactoryBot.build(:task, content: "")
    @blank_priority = FactoryBot.build(:task, priority: "")
    @blank_deadline = FactoryBot.build(:task, deadline: "")
    @blank_status = FactoryBot.build(:task, status: "")
    @error_priority = FactoryBot.build(:task, priority: "")
    @error_status = FactoryBot.build(:task, status: "")
    @not_empty_task = FactoryBot.build(:task)
  end

  describe 'バリデーションテスト' do
    it "titleが空ならバリデーションが通らない" do
      expect(@blank_title).not_to be_valid
    end

    it 'detailsが空ならバリデーションが通らない' do
      expect(@blank_content).not_to be_valid
    end

    it 'priorityが空ならバリデーションが通らない' do
      expect(@blank_priority).not_to be_valid
    end

    it 'priorityがAAAならバリデーションが通らない' do
      expect(@error_priority).not_to be_valid
    end

    it 'statusが空ならバリデーションが通らない' do
      expect(@blank_status).not_to be_valid
    end

    it 'statusがBBBならバリデーションが通らない' do
      expect(@error_status).not_to be_valid
    end

    it 'deadlineが空ならバリデーションが通らない' do
      expect(@blank_deadline).not_to be_valid
    end

    it 'title・content・deadline・priority・status・user_idに内容が記載されていればバリデーションが通る' do
      expect(@not_empty_task).to be_valid
    end
  end

  describe 'scopeテスト' do
    context 'タイトル検索テスト' do
      it '検索ワード：検索、2件見つかる'do
        expect(Task.sort_title("検索").count).to eq 2
      end

      it '検索ワード：けんさく、1件見つかる'do
        expect(Task.sort_title("けんさく").count).to eq 1
      end

      it '検索ワード：テスト、3件見つかる'do
        expect(Task.sort_title("テスト").count).to eq 3
      end
    end

    context 'ステータス検索テスト' do
      it '検索ワード：未着手、2件見つかる'do
        expect(Task.sort_status("未着手").count).to eq 2
      end

      it '検索ワード：完了、1件見つかる'do
        expect(Task.sort_status("完了").count).to eq 1
      end
    end

    context 'タイトル・ステータス検索テスト' do
      it '検索ワード：タイトル：検索、未着手、2件見つかる'do
        expect(Task.sort_title_and_status("検索", "未着手").count).to eq 2
      end

      it '検索ワード：タイトル：けんさく、ステータス：完了、1件見つかる' do
        expect(Task.sort_title_and_status("けんさく","完了").count).to eq 1
      end
    end

    context 'ソートテスト' do
      it '終了期限（降順）でソートすると2022が最初になる' do
        expect(Task.desc_deadline[0].deadline).to eq "2022-03-09".to_date
      end

      it '優先順位（高）でソートするとAが最初になる' do
        expect(Task.asc_priority[0].priority).to eq 'A'
      end
    end
  end
end
