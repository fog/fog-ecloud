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
          service.ssh_key_delete(href).body
        end
        alias_method :destroy, :delete

        def edit(options = {})
          # Make sure we only pass what we should
          new_options = {}
          new_options[:uri] = href
          if options[:name].nil?
            new_options[:name] = name
          else
            new_options[:name] = options[:name]
          end
          if options[:default].nil?
            new_options[:default] = default
          else
            new_options[:default] = options[:default]
          end

          service.ssh_key_edit(new_options).body
        end

        def id
          href.scan(/\d+/)[0]
        end
      end
    end
  end
end
