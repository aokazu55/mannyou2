require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  let!(:user) { User.create(name: "tamu", email: "tamu@gmail.com", password: "tamutamu") }
  let!(:task_1) { Task.create(title: 'task_1', content: 'test_content', deadline: '2022-05-03', status: '未着手', priority: '高', user: user) }
  let!(:task_2) { Task.create(title: 'task_1', content: 'test_content', deadline: '2022-04-01', status: '完了', priority: '中', user: user) }
  let!(:task_3) { Task.create(title: 'task_3', content: 'test_content', deadline: '2022-03-09', status: '未着手', priority: '低', user: user) }

  describe 'バリデーションテスト' do
    it "「title」が空ならバリデーションが通らない" do
      # user = User.create(name: "tamu", email: "tamu@gmail.com", password: "tamutamu")
      blank_title =  Task.new(title: '', content: 'test_content', deadline: '2022-05-03', status: '未着手', priority: '高', user: user)
      expect(blank_title).not_to be_valid
    end

    it '「content」が空ならバリデーションが通らない' do
      # user = User.create(name: "tamu", email: "tamu@gmail.com", password: "tamutamu")
      blank_content = Task.new(title: 'test_title', content: '', deadline: '2022-05-03', status: '未着手', priority: '高', user: user)
      expect(blank_content).not_to be_valid
    end

    it '「priority」が空ならバリデーションが通らない' do
      # user = User.create(name: "tamu", email: "tamu@gmail.com", password: "tamutamu")
      blank_priority = Task.new(title: 'test_title', content: 'test_content', deadline: '2022-05-03', status: '未着手', priority: '', user: user)
      expect(blank_priority).not_to be_valid
    end

    it '「status」が空ならバリデーションが通らない' do
      # user = User.create(name: "tamu", email: "tamu@gmail.com", password: "tamutamu")
      blank_status = Task.new(title: 'test_title', content: 'test_content', deadline: '2022-05-03', status: '', priority: '高', user: user)
      expect(blank_status).not_to be_valid
    end

    it '「deadline」が空ならバリデーションが通らない' do
      # user = User.create(name: "tamu", email: "tamu@gmail.com", password: "tamutamu")
      blank_deadline = Task.new(title: 'test_title', content: 'test_content', deadline: '', status: '未着手', priority: '高', user: user)
      expect(blank_deadline).not_to be_valid
    end

    it '「title・content・deadline・priority・status」に内容が記載されていればバリデーションが通る' do
      # user = User.create(name: "tamu", email: "tamu@gmail.com", password: "tamutamu")
      not_empty_task = Task.new(title: "test_title", content: "test_content", deadline: "2040-03-11", priority: "高", status: "完了", user: user)
      expect(not_empty_task).to be_valid
    end
  end

  describe 'scopeテスト' do
    context 'タイトル検索テスト' do
      it '検索ワード：検索、2件見つかる'do
        expect(Task.title_search('1')).to include(Task.find_by(title: 'task_1'))
        expect(Task.title_search('1').count).to eq 2
      end

      it '検索ワード：けんさく、1件見つかる'do
        expect(Task.title_search('3').count).to eq 1
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
        expect(Task.sort_deadline_asc[0].deadline).to eq "2022-03-09"
      end
      it '【優先順位でソート】を押すと「高」が最初になる' do
        expect(Task.sort_priority_desc[0].priority).to eq '高'
      end
    end
  end
end
