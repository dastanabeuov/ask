require 'rails_helper'

feature 'DELETE QUESTION', %q{
  Authenticated user delete question
  Other authenticated user delete question
  Unauthenticated user delete question
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create :question, user: user }

  scenario 'Authenticated user delete' do
    sign_in(user)
    visit question_path(question)
    
    click_on 'Delete question'
    
    expect(page).to have_content 'Your question has been deleted.'
    expect(page).to have_no_content 'MyString'
    expect(page).to have_no_content 'MyText'
  end

  scenario 'Other authenticated user delete' do
    sign_in(user2)
    visit question_path(question)
    
    expect(page).to have_no_link('Delete question')
  end

  scenario 'Unauthenticated user delete' do
    visit question_path(invalid_question)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end