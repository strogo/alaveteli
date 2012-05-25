module MailerHelper
    def contact_from_name_and_email
        contact_name = MySociety::Config.get("TRACK_SENDER_NAME", 'Alaveteli')
        contact_email = MySociety::Config.get("TRACK_SENDER_EMAIL", 'contact@localhost')
        return "#{contact_name} <#{contact_email}>"
    end
end
