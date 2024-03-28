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

      # Generate the PDF content
      attachments['attachment.pdf'] = WickedPdf.new.pdf_from_string(
        render_to_string(pdf: "invitation", template: 'events/invitation', formats: [:html])
      )


    # pdf_content = render_to_string(pdf: "event_details", template: "events/show.pdf.erb", layout: false, encoding: "UTF-8")

    # Attach the PDF to the email
    # attachments["event_details.pdf"] = pdf_content

      mail(to: @recipient_email, subject: 'Invitation to Event')
  end
end
