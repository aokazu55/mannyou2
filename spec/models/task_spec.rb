require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  before do
    FactoryBot.create(:search_task_01)
    FactoryBot.create(:search_task_02)
    FactoryBot.create(:search_task_03)
    @blank_title = FactoryBot.build(:task, title: "")
    @blank_content = FactoryBot.build(:task, content: "")
    @blank_priority = FactoryBot.build(:task, priority: "")
    @blank_deadline = FactoryBot.build(:task, deadline: "")
    @blank_status = FactoryBot.build(:task, status: "")
    @not_empty_task = FactoryBot.build(:task)
  end

  describe 'バリデーションテスト' do
    it "「title」が空ならバリデーションが通らない" do
      expect(@blank_title).not_to be_valid
    end

    it '「content」が空ならバリデーションが通らない' do
      expect(@blank_content).not_to be_valid
    end

    it '「priority」が空ならバリデーションが通らない' do
      expect(@blank_priority).not_to be_valid
    end

    it '「status」が空ならバリデーションが通らない' do
      expect(@blank_status).not_to be_valid
    end

    it '「deadline」が空ならバリデーションが通らない' do
      expect(@blank_deadline).not_to be_valid
    end

    it '「title・content・deadline・priority・status」に内容が記載されていればバリデーションが通る' do
      expect(@not_empty_task).to be_valid
    end
  end


  describe 'scopeテスト' do
    context 'タイトル検索テスト' do
      it '検索ワード：検索、2件見つかる'do
        expect(Task.title_search("検索").count).to eq 2
      end

      it '検索ワード：けんさく、1件見つかる'do
        expect(Task.title_search("けんさく").count).to eq 1
      end
    end

    context 'ステータス検索テスト' do
      it '検索ワード：未着手、2件見つかる'do
        expect(Task.status_search("未着手").count).to eq 2
      end

      it '検索ワード：完了、1件見つかる'do
        expect(Task.status_search("完了").count).to eq 1
      end
    end

    context 'ソートテスト' do
      it '【完了期限でソート】すると2021が最初になる' do
        expect(Task.sort_deadline_asc[0].deadline).to eq "2021-03-09"
      end

      it '【優先順位でソート】を押すと「高」が最初になる' do
        expect(Task.sort_priority_desc[0].priority).to eq '高'
      end
    end
  end
end
