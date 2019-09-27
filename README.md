Workstation
=========

This role installs my personal workstation setup.

Requirements
------------

Make sure the EPEL Repo is enable. See (mto79/ansible_role_epel_role)[https://github.com/mto79/ansible_role_repo_epel] 


Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

Give a variable usr to the mto79.workstation in the format
  workstation_user:
    uname: 
    upass: 
    ukey: 

    - hosts: servers
      roles:
         - { role: mto79.workstation, usr: "{{ workstation_user }}" }


Issues
-------
Phyton-psutils for dconf ansible module.
phyton3-psutils not available for Red Hat 8. Temp fix is to install python3-psutil-5.4.3-4.fc28.x86_64 and wait for Red Hat. 
In Fedora 30 there is just the package.


License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
