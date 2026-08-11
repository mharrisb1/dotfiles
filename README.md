# dotfiles

Config files to be symlinked to [`$XDG_CONFIG_HOME`](https://specifications.freedesktop.org/basedir-spec/latest/#variables).

## Tools

| Name       | Link                                        |
| ---------- | ------------------------------------------- |
| alacritty  | https://github.com/alacritty/alacritty      |
| codebook   | https://github.com/blopker/codebook         |
| delta      | https://github.com/dandavison/delta         |
| helix      | https://helix-editor.com                    |
| lazydocker | https://github.com/jesseduffield/lazydocker |
| lazygit    | https://github.com/jesseduffield/lazygit    |
| xplr       | https://xplr.dev                            |
| zellij     | https://zellij.dev                          |

## Setup

Setup a fresh Ubuntu install:

```bash
sudo apt update && sudo apt install -y ansible git
git clone https://github.com/mharrisb1/dotfiles ~/dotfiles
cd ~/dotfiles
ansible-playbook setup/main.yml
```
