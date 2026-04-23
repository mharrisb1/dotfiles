ARG OS_VERSION=24.04
FROM ubuntu:${OS_VERSION}

# --- 1. SYSTEM & ROOT CONFIG ---
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    software-properties-common curl git gnupg ca-certificates locales sudo \
    && add-apt-repository ppa:dotnet/backports -y \
    && apt-get update && apt-get install -y \
    zsh build-essential clangd libxml2-utils openjdk-21-jdk \
    dotnet-sdk-9.0 dotnet-runtime-9.0 \
    && locale-gen en_US.UTF-8 \
    && useradd -m -s /usr/bin/zsh developer \
    && echo "developer ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers \
    && rm -rf /var/lib/apt/lists/*

# --- 2. USER ENVIRONMENT ---
USER developer
WORKDIR /home/developer
ENV HOME=/home/developer \
    SHELL="/usr/bin/zsh" \
    PATH="/home/developer/.local/bin:/home/developer/.cargo/bin:/usr/local/go/bin:/home/developer/go/bin:${PATH}" \
    EDITOR="hx" \
    XDG_CONFIG_HOME="/home/developer/.config"

ENV NVM_DIR="/home/developer/.nvm" \
    HELIX_RUNTIME="/home/developer/helix/runtime"

RUN mkdir -p "$XDG_CONFIG_HOME"
RUN mkdir -p "$NVM_DIR"

COPY --chown=developer:developer nvm/ $NVM_DIR
COPY --chown=developer:developer helix/ $XDG_CONFIG_HOME/helix/
COPY --chown=developer:developer zellij/ $XDG_CONFIG_HOME/zellij/
COPY --chown=developer:developer lazygit/ $XDG_CONFIG_HOME/lazygit/
COPY --chown=developer:developer xplr/ $XDG_CONFIG_HOME/xplr/
COPY --chown=developer:developer delta/ $XDG_CONFIG_HOME/delta/

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
    && sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc \
    && curl https://sh.rustup.rs -sSfL | sh -s -- -y --default-toolchain stable --profile minimal \
    && curl -sSfL https://go.dev/dl/go1.26.2.linux-amd64.tar.gz | sudo tar -C /usr/local -xzf - \
    && curl -LsSf https://astral.sh/uv/install.sh | sh \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" && nvm install --lts

# --- 3. TOOLS & CLI UTILITIES ---
RUN go install github.com/jesseduffield/lazydocker@latest \
    && go install github.com/jesseduffield/lazygit@latest \
    && go install mvdan.cc/sh/v3/cmd/shfmt@latest \
    && cargo install --locked zellij git-delta \
    && git clone --depth 1 https://github.com/helix-editor/helix \
    && cd helix && cargo install --profile opt --path helix-term --locked && cd .. \
    && git clone --depth 1 https://github.com/sayanarijit/xplr.git \
    && cd xplr && cargo build --locked --release --bin xplr && sudo cp target/release/xplr /usr/local/bin/ && cd .. \
    && git clone --depth 1 https://github.com/artempyanykh/marksman.git \
    && cd marksman && make install && cd .. \
    && uv tool install ansible-lint==26.4.0 \
    && uv tool install basedpyright==1.39.0 \
    && uv tool install ruff@0.15.9

CMD ["zsh"]