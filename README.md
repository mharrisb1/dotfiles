# dotfiles

Configuration and setup for minimal and portable development setup across most major Linux distros (Debian and RedHat families).

## Tools

| Name       | Link                          |
| ---------- | ----------------------------- |
| git        | https://github.com/git/git    |
| nnn        | https://github.com/jarun/nnn  |
| tmux       | https://github.com/tmux/tmux  |
| vim        | https://github.com/vim/vim    |

## Installation and Setup

> [!NOTE]
> Must have [Ansible installed](https://docs.ansible.com/projects/ansible/latest/installation_guide/installation_distros.html)

```bash
ansible-playbook setup.yml --skip-tags packages
sudo ansible-playbook setup.yml --tags packages
```

