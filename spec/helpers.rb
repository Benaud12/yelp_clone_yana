module Helpers

  def sign_up(user)
    visit '/'
    click_link 'Sign up'
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link "Review #{restaurant.name}"
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

end
