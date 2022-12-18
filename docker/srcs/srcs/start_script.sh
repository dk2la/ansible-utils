#!/bin/sh

echo "Whoami command execute"
whoami

echo "PWD command execute"
pwd

echo "CAT os-release"
cat /etc/os-release

echo "Start server"
nohup sh -c "vault server -config='/root/srcs/vault-config.hcl' > /root/log/vault.log 2>&1" > /root/log/nohup.log &

echo "PS command execute"
ps

export VAULT_ADDR='http://127.0.0.1:8200'

sleep 10
export
sleep 10

vault operator init > vault_init.txt
cat vault_init.txt

echo "Unseal server"
vault operator unseal $(grep 'Key 1:' vault_init.txt | awk '{print $NF}')
vault operator unseal $(grep 'Key 2:' vault_init.txt | awk '{print $NF}')
vault operator unseal $(grep 'Key 3:' vault_init.txt | awk '{print $NF}')

echo "Login with root token"
VAULT_TOKEN=$(grep 'Initial Root Token:' vault_init.txt | awk '{print $NF}')
