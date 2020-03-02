require 'rails_helper'

RSpec.describe "tasks/show", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      :title => "Title",
      :content => "MyText",
      :priority => "Priority",
      :status => "Status",
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Priority/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/2/)
  end
end
