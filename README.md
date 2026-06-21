# dotfiles

Config files to be symlinked to [`$XDG_CONFIG_HOME`](https://specifications.freedesktop.org/basedir-spec/latest/#variables).

## Configs

| Name       | Link                                        |
| ---------- | ------------------------------------------- |
| alacritty  | https://github.com/alacritty/alacritty      |
| delta      | https://github.com/dandavison/delta         |
| helix      | https://helix-editor.com                    |
| lazydocker | https://github.com/jesseduffield/lazydocker |
| lazygit    | https://github.com/jesseduffield/lazygit    |
| xplr       | https://xplr.dev                            |
| zellij     | https://zellij.dev                          |

## Setup

Setup a fresh Ubuntu install:

```bash
# 1. Install Ansible
sudo apt update && sudo apt install -y ansible git

# 2. Clone this repo to ~/dotfiles
git clone https://github.com/mharrisb1/dotfiles ~/dotfiles
cd ~/dotfiles

# 3. Install required Ansible collections
ansible-galaxy collection install -r ansible/requirements.yml

# 4. Run the playbook
ansible-playbook ansible/setup.yml
```
