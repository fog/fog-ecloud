module Fog
  module Compute
    class Ecloud
      class Real
        include Shared

        def ssh_key_edit(data)
          request(
            :body => generate_ssh_key_edit_request(data),
            :expects => 200,
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

      class Mock
        def ssh_key_edit(data)
          ssh_key_id = id_from_uri(data[:uri]).to_i
          if self.data[:ssh_keys][ssh_key_id]
            self.data[:ssh_keys][ssh_key_id][:name] = data[:name]
            self.data[:ssh_keys][ssh_key_id][:default] = data[:default]
            ssh_key = self.data[:ssh_keys][ssh_key_id]
            response(:body => Fog::Ecloud.slice(ssh_key, :id, :admin_organization))
          else
            response(:status => 404)
          end
        end
      end
    end
  end
end
