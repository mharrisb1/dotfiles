# dotfiles

Config files to be symlinked to [`$XDG_CONFIG_HOME`](https://specifications.freedesktop.org/basedir-spec/latest/#variables).

> [!TIP]
> Minimal dotfiles available [here](https://github.com/mharrisb1/dotfiles/tree/minimal)

## Tools

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

Bootstrap a fresh Ubuntu install:

```bash
# 1. Install Ansible
sudo apt update && sudo apt install -y ansible git

# 2. Clone this repo to ~/dotfiles
git clone https://github.com/mharrisb1/dotfiles ~/dotfiles
cd ~/dotfiles

# 3. Install required Ansible collections
ansible-galaxy collection install -r ansible/requirements.yml

# 4. Run the playbook (will prompt for sudo password)
ansible-playbook ansible/setup.yml --ask-become-pass
```

> [!NOTE]
> Docker group membership requires a logout/login (or `newgrp docker`) to take effect.
