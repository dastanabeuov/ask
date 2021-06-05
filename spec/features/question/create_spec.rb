require 'rails_helper'

feature 'CREATE QUESTION', %q{
  Authenticated user add question valid attribute
  Authenticate user add question invalid attribute
  Authenticate user save question with attached file
  Unauthenticated user tries add question
} do

  given(:user) { create(:user) }
  
  background do
    sign_in(user)
    visit questions_path
    click_on 'Ask'
  end
    
  scenario 'Authenticated user add new question' do
    fill_in 'Title', with: 'MyString'
    fill_in 'Body', with: 'MyText'
    click_on 'Create question'
    
    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
  end

  scenario 'Authenticate user add question errors attribute' do
    click_on 'Create question'

    expect(page).to have_content "Title can't be blank"
  end

  scenario 'Authenticate user save question with attached file' do
    fill_in 'Title', with: 'MyString'
    fill_in 'Body', with: 'MyText'
    
    click_on 'Create question'

    expect(page).to have_link 'rails_helper.rb'
    expect(page).to have_link 'spec_helper.rb'      
  end

  scenario 'Unauthenticated user tries add question' do
    visit questions_path
    click_on 'Ask'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end