module Fog
  module Compute
    class Ecloud
      class Real
        include Shared

        def ssh_key_edit(data)
          request(
            :body => generate_ssh_key_edit_request(data),
            :expects => [202, 204],
            :method => "PUT",
            :headers => {},
            :uri => data[:uri],
            :parse => true
          )
        end

        private

        def generate_ssh_key_edit_request(data)
          xml = Builder::XmlMarkup.new
          xml.SshKey(:name => data[:name]) do
            xml.Default data[:default]
          end
        end
      end
    end
  end
end
