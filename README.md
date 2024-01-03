# Vagrant box with Vault and Consul cluster

```
vagrant up
```
```
vagrant ssh (in new tab)
```
```
Vault: 127.0.0.1:8200
```
```
Consul: 127.0.0.1:8500
```
## Inside box
```
export VAULT_ADDR=http://:8200
```
```
vault status
```
```
vault operator init
```
```
vault operator unseal
```
