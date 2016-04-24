class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(sign_up_params)
    @user.interest = params[:interest_array].map { |k| "#{k}" }.join(",")
	if @user.save
		sign_in(@user, bypass: true)
		redirect_to root_path, notice: 'User was successfully registered.'
	else
		redirect_to new_user_registration_path
	end
  end

	private

	def sign_up_params
		params.require(:user).permit(:name, :email, :interest_array, :password, :password_confirmation)
	end

	def account_update_params
		params.require(:user).permit(:name, :email, :interest_array, :password, :password_confirmation, :current_password)
	end
end