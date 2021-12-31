 # Description
# ===========
# This playbook create a PostgreSQL server and an instance of PostgreSQL Database

---
- hosts: localhost
  tasks:
    - name: Prepare random postfix
      set_fact:
        rpfx: "{{ 1000 | random }}"
      run_once: yes

- hosts: localhost
  #roles:
  #  - azure.azure_preview_modules
  vars:
    resource_group: "hyd-rg"
    location: westeurope
    postgresqlserver_name: postgresql999
    postgresqldb_name: sqldbtest
    admin_username: admxyz
    admin_password: Abcpasswordxyz12!
  tasks:
    - name: Create a resource group
      azure_rm_resourcegroup:
        name: "hyd-rg"
        location: "westeurope"

    - name: Create PostgreSQL Server
      azure_rm_postgresqlserver:
        resource_group: "hyd-rg"
        name: "postgresql999"
        sku:
          name: B_Gen5_1
          tier: Basic
          capacity: 1
        location: "westeurope"
        enforce_ssl: True
        admin_username: "admxyz"
        admin_password: "Abcpasswordxyz12!"
        storage_mb: 51200

    - name: Create instance of PostgreSQL Database
      azure_rm_postgresqldatabase:
        resource_group: "hyd-rg"
        server_name: "postgresql999"
        name: "sqldbtest"

