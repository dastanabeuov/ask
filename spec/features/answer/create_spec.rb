require 'rails_helper'

feature 'CREATE ANSWER', %q{
  Authenticated user create answer
  Authenticated user tries create with erros answer
  Authenticated user Save answer with attached file
  Unauthenticated user tries create answer
} do
  
  given(:user) { create(:user) }
  given(:question) { create :question, user_id: user.id }

  sign_in(user)
  visit question_path(question)

  scenario 'Authenticated user', js: true do
    fill_in 'Body', with: 'MyText'
    
    click_on 'Create answer'

    expect(page).to have_content 'MyText'
  end

  scenario 'Authenticated user tries create with erros answer' do
    click_on 'Create answer'
    
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Save answer with attached file' do
    fill_in 'Body', with: 'MyText'

    click_on 'Create answer'

    expect(page).to have_content 'MyText'
    expect(page).to have_link 'rails_helper.rb'
    expect(page).to have_link 'spec_helper.rb'      
  end    

  scenario 'Unauthenticated user tries create answer' do
    visit question_path(question)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end