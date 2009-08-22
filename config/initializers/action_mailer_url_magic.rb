# Borrowed from Nick Kallen, with minor modifications.
# http://pivots.pivotallabs.com/users/nick/blog/articles/281-how-i-learned-to-stop-hating-and-love-action-mailer

module UrlWriterPersistHostInfo
  module ActionController
    def self.included(ac)
      ac.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def persist_host_info
        request = self.request
        ::Notifier.instance_eval do
          default_url_options[:host] = request.host
          default_url_options[:port] = request.port unless request.port == 80

          protocol = /(.*):\/\//.match(request.protocol)[1] if request.protocol.ends_with?("://")
          default_url_options[:protocol] = protocol
        end
      end
    end
  end
end

ActionController::Base.send(:include, UrlWriterPersistHostInfo::ActionController)

