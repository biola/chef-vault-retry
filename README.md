## Overview

Wraps `ChefVault::Item.load` with a new method `ChefVaultRetry::Item.load` that will periodically retry to decrypt the secret if an exception is raised. This is primarily intended to ease the bootstrapping of new systems by keeping chef-client runs from failing.

## Use

Replace the following code in your recipes:

```
chef_gem 'chef-vault' do
  compile_time true if respond_to?(:compile_time)
end

require 'chef-vault'

item = ChefVault::Item.load('passwords', 'root')
item['password']
```

with this instead:

```
chef_gem 'chef-vault-retry' do
  compile_time true if respond_to?(:compile_time)
end

require 'chef-vault-retry'

item = ChefVaultRetry::Item.load('passwords', 'root')
item['password']
```

The same ChefVault::Item.load method will be called, but if a secret decryption exception is raised:
1. A message will output about the failure
  * e.g. `SecretDecryption exception raised; please refresh vault item (passwords/root)`
2. Recipe execution will pause for 30 seconds
3. The process will repeat
  * It will repeat this 40 times by default (~20 minutes). This can be overwritten by passing a Fixnum as the `retries` argument of `ChefVaultRetry::Item.load`