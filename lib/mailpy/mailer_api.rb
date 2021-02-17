require 'httparty'

class MailerApi
  def initialize(mail, options = {})
    @mail = mail
    @options = options
  end

  def send
    result = begin
      HTTParty.post(
        options[:endpoint],
        body: form_data,
        headers: headers
      )
    rescue errno::
        nil
    end
  end

  private
    attr_reader :mail, :options

    def form_data
      {
        to: mail.to.try(:join, ', '),
        cc: mail.cc.try(:join, ', '),
        bcc: mail.bcc.try(:join, ', '),
        from: mail.from.try(:join, ', '),
        subject: mail.subject,
        body: mail.body.to_s
      }.to_json
    end

    def headers
      { 'Content-Type': 'application/json' }.merge!(options[:headers])
    end
end
