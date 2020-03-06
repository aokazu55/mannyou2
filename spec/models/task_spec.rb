require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do

  describe 'バリデーションテスト' do
    it 'titleが空ならバリデーションが通らない' do
      task = Task.new(title: '', content: '失敗テスト', deadline: '失敗テスト', priority: '失敗テスト', status: '失敗テスト')
      expect(task).not_to be_valid
    end

    it 'contentが空ならバリデーションが通らない' do
      task = Task.new(title: '失敗テスト２', content: '', deadline: '失敗テスト２', priority: '失敗テスト２', status: '失敗テスト2')
      expect(task).not_to be_valid
    end

    it 'deadlineが空ならバリデーションが通らない' do
      task = Task.new(title: '失敗テスト３', content: '失敗テスト３', deadline: '', priority: '失敗テスト３', status: '失敗テスト3')
      expect(task).not_to be_valid
    end

    it 'priorityが空ならバリデーションが通らない' do
      task = Task.new(title: '失敗テスト４', content: '失敗テスト４', deadline: '失敗テスト４', priority: '', status: '失敗テスト4')
      expect(task).not_to be_valid
    end

    it 'statusが空ならバリデーションが通らない' do
      task = Task.new(title: '失敗テスト5', content: '失敗テスト5', deadline: '失敗テスト5', priority: '失敗テスト5', status: '')
      expect(task).not_to be_valid
    end

    it '入力欄全てに内容が記載されていればバリデーションが通る' do
      task = Task.new(title: '成功テスト', content: '成功テスト', deadline: '成功テスト', priority: '成功テスト', status: '成功テスト')
      expect(task).to be_valid
    end
  end

  task = Task.create(title: 'test_title', content: 'test_content', deadline: "2020-12-12", priority: '高', status: '未着手')
