require 'rails_helper'

feature 'CHOOSE ACCEPT', %q{
  Authenticated user correct accept
  Authenticated user non author question
  Unauthenticated user try change correct accept
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: author) }
  given!(:answers) { create_list(:answer, 3, question: question, user: user ) }

  scenario 'Authenticated user correct accept', js: true do
    sign_in(author)
    visit question_path(question)

    visit question_path(question)

    click_on 'Accept answer'

    expect(page).to_not have_link 'The accept answer'
  end

  scenario "Authenticated user non author question" do
    sign_in(user2)

    visit question_path(question)
    
    expect(page).to_not have_link "Accept answer"
  end

  scenario 'Unauthenticated user try change correct accept' do
    visit question_path(question)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to_not have_link 'Accept answer'
  end
end