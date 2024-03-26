class UsersController < ApplicationController
  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to '/users/edit', notice: 'Subscription was successfully updated.'
    else
      redirect_to '/users/events', notice: "error updating user"
    end
  end

  private

  def user_params
    params.require(:user).permit(:subscription_type, :card_cvc, :card_expiry, :card_name, :card_number)
  end
end
