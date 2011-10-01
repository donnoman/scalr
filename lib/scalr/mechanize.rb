require "mechanize"

module Scalr
  class Mechanize
    class ScalrError < RuntimeError; end
    class InvalidInputError < ScalrError; end

    mattr_accessor :endpoint
    @@endpoint = "my.scalr.net"

    mattr_accessor :user
    @@user = nil

    mattr_accessor :password
    @@password = nil

    mattr_accessor :agent
    @@agent = nil

    mattr_accessor :debug
    @@debug = false

    class << self

      def server_snapshot(options={})
        raise InvalidInputError, "server_id missing" unless options[:server_id]
        raise InvalidInputError, "role_name missing" unless options[:role_name]
        raise InvalidInputError, "replacment_policy missing" unless options[:replacement_policy]
        page = agent.post("https://#{endpoint}/servers/xServerCreateSnapshot", "serverId" => options[:server_id], "roleName" => options[:role_name], "replaceType" => options[:replacement_policy])
        raise ScalrError, "server_snapshot unsuccessful #{page.body}" unless JSON.parse(page.body)['success']
        page
      end

      private

        def agent
          @@agent ||= begin
            a =::Mechanize.new { |a|
              a.log = Logger.new(STDERR) if @@debug
              a.gzip_enabled = false #prevents too many connection resets (due to end of file reached - EOFError)
            }
            page = a.get("https://#{endpoint}")
            form = page.forms_with(:action => '/guest/xLogin/').first
            form.scalrLogin = user
            form.scalrPass = password
            form.checkbox_with(:name => 'scalrKeepSession').checked = true
            page = a.submit(form, form.buttons.first)
            raise ScalrError, "Scalr Mechanize authentication unsuccessful #{page.body}" unless JSON.parse(page.body)['success']
            a
          end
        end

    end

  end
end