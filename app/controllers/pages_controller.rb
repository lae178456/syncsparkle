class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def invite_page
    if params[:email].present?
      emails = [params[:email]]
      emails.each do |email|
        mail = InvitationMailer.with(event: @event, event_url: "", recipient_email: email).invitation
        mail.deliver_now
      end

      flash.alert = "You've sent an email to #{emails.first}"
    end
  end

end
