provider, config = :ecloud, compute_providers[:ecloud]

Shindo.tests("Fog::Compute[:#{provider}] | ssh_keys", [provider.to_s]) do
  connection = Fog::Compute[provider]
  @organization = connection.organizations.first
  @admin_organization = @organization.admin
  @admin_organization.reload
  @ssh_keys = @admin_organization.ssh_keys

  tests('#all').succeeds do
    returns(false) { @ssh_keys.empty? }
  end

  tests('#get').succeeds do
    ssh_key = @ssh_keys.first

    returns(false) { @ssh_keys.get(ssh_key.href).nil? }
  end

  tests('#create').succeeds do
    new_key = @ssh_keys.create(name: "testing")
    @key_id = new_key.id || nil
    returns(false) { new_key.nil? }
  end

  tests('#edit').succeeds do
    the_key = @ssh_keys.get(@key_id)
    returns(false) { the_key.nil? }
    the_key.edit(name: "more testing")
    the_key.reload
    returns(false) { the_key.name != "more testing" }
  end

  tests('#delete').succeeds do
    the_key = @ssh_keys.get(@key_id)
    returns(false) { the_key.nil? }
    the_key.delete
    the_key = @ssh_keys.get(@key_id)
    returns(false) { !the_key.nil? }
  end
end
