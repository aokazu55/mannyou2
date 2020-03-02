require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト', deadline: '失敗テスト', priority: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト２', content: '', deadline: '失敗テスト２', priority: '失敗テスト２')
    expect(task).not_to be_valid
  end

  it 'deadlineが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト３', content: '失敗テスト３', deadline: '', priority: '失敗テスト３')
    expect(task).not_to be_valid
  end

  it 'priorityが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト４', content: '失敗テスト４', deadline: '失敗テスト４', priority: '')
    expect(task).not_to be_valid
  end

  it '入力欄全てに内容が記載されていればバリデーションが通る' do
    # ここに内容を記載する
    task = Task.new(title: '成功テスト', content: '成功テスト', deadline: '成功テスト', priority: '成功テスト')
    expect(task).to be_valid
  end
end
