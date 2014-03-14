class Authentication < ActiveRecord::Base
  belongs_to :user

  def facebook?
    return provider == 'facebook'
  end

  def google?
    return provider == 'google_oauth2'
  end

end
