module Fog
  module Compute
    class Ecloud
      class Real
        include Shared

        def ssh_key_create(data)
          validate_data([:name], data)

          request(
            :body => generate_ssh_key_create_request(data),
            :expects => 201,
            :method => "POST",
            :headers => {},
            :uri => data[:uri],
            :parse => true
          )
        end

        private

        def generate_ssh_key_create_request(data)
          xml = Builder::XmlMarkup.new
          xml.CreateSshKey(:name => data[:name]) do
            xml.Default data[:default]
          end
        end
      end
    end
  end
end
