module Spina
  class InquiryMailer < ActionMailer::Base
    layout 'spina/email'

    def inquiry(inquiry)
      @inquiry = inquiry
      @account = Account.first

      # attachments.inline['logo.jpg'] = LogoUploader.new.read(@account.logo) if @account.logo.url

      mail( 
        to: "\"#{@account.name}\" <#{ @account.email }>", 
        from: "\"#{@inquiry.name}\" <#{@inquiry.email}>",
        subject: @inquiry.message.truncate(97, separator: ' ')
      )
    end

  end
end
