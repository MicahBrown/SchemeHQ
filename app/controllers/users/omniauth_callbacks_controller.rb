class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(omniauth_params)

    if @user.is_a? User
      if @user.email.blank?
        redirect_to new_user_session_path, alert: "No valid email was linked from your Google account."
      else
        if existing_user = User.where("LOWER(email) = ?", @user.email.downcase).first
          @user = existing_user
          @user.add_omniauth(omniauth_params)
        end

        if @user.save
          sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
          set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
        else
          redirect_to new_user_session_path, alert: "Google authentication failed."
        end
      end
    else
      redirect_to new_user_session_path, alert: "Google authentication failed."
    end
  end

  def failure
    redirect_to root_path
  end

  private

    def omniauth_params
      request.env["omniauth.auth"]
    end
end