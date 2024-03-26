class InvitationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invitation.subject
  #
  def invitation
      @event = params[:event]
      @event_url = params[:event_url]
      @recipient_email = params[:recipient_email]
      mail(to: @recipient_email, subject: 'Invitation to Event')
  end
end
