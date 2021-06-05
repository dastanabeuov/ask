require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :user }
  it { should belong_to :question }

  it { should validate_presence_of :body }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answers) { create_list(:answer, 3, question: question, user: user) }

  describe 'method "set_accept":' do
    before do 
      answers.last.set_accept
      answers.first.set_accept
    end

    it 'correct answer set_accept' do
      expect(answers.first).to be_accept
    end

    it 'correct answer only one set_accept' do
      expect(question.answers.where(accept: true).count).to eq 1
    end
  end
end