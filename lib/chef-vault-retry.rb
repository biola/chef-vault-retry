#
# Author:: Troy Ready (<troy.ready@biola.edu>)
#
# Copyright:: 2015, Biola University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef-vault'

class ChefVaultRetry
  class Item
    def self.load(v, i, retries = 40, databag_fallback = true)
      if ChefVault::Item.vault?(v, i)
        retries.times do
          begin
            return ChefVault::Item.load(v, i)
          rescue ChefVault::Exceptions::SecretDecryption
            puts 'SecretDecryption exception raised; '\
                 "please refresh vault item (#{v}/#{i})"
            sleep 30
            next
          end
        end
        fail "Failed after #{retries} attempts to decrypt #{v}/#{i}"
      elsif databag_fallback
        Chef::DataBagItem.load(v, i)
      else
        fail "#{v}/#{i} vault item not found and databag_fallback not permitted"
      end
    end
  end
end
