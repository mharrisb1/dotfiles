# dotfiles

Config files to be symlinked to [`$XDG_CONFIG_HOME`](https://specifications.freedesktop.org/basedir-spec/latest/#variables).

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

## Dev Container

Quickly deploy this in a [Dev Container](https://containers.dev):

> [!NOTE]
> Must have [Dev Container CLI](https://github.com/devcontainers/cli)

```bash
devcontainer up --config .devcontainer/devcontainer.json --workspace-folder .
devcontainer exec --workspace-folder . zsh -c "zellij attach -c dev || zellij"
```
