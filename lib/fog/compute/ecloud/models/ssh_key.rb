module Fog
  module Compute
    class Ecloud
      class SshKey < Fog::Ecloud::Model
        identity :href

        attribute :name, :aliases => :Name
        attribute :type, :aliases => :Type
        attribute :other_links, :aliases => :Links
        attribute :default, :aliases => :Default, :type => :boolean
        attribute :finger_print, :aliases => :FingerPrint
        attribute :private_key, :aliases => :PrivateKey

        def delete
          data = service.ssh_key_delete(href).body
          self.service.tasks.new(data)
        end
        alias_method :destroy, :delete

        def id
          href.scan(/\d+/)[0]
        end
      end
    end
  end
end
