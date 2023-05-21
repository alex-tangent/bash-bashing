# Start with the base image
FROM ubuntu:jammy AS builder

LABEL version="1.0"
LABEL description="Devcontainer image with poetry and bun multireppo"
LABEL maintainer="contact@tangent.center"

ARG HOME="/root"

# Env vars
ENV DEBIAN_FRONTEND=noninteractive \
    XDG_CONFIG_HOME="$HOME/.config" \
    BUN_INSTALL="${HOME}/.bun" \
    POETRY_HOME="${HOME}/.poetry"
ENV PATH="${HOME}/.cargo/bin:${BUN_INSTALL}/bin:${POETRY_HOME}/bin:${PATH}"

# Install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install --no-install-recommends apt-utils 2>&1 && \
    apt-get -y install iproute2 procps lsb-release pkg-config libssl-dev cmake \
    software-properties-common cargo locales \
    curl git gh unzip lynx jq xsel fish fzf bat micro fd-find && \
    locale-gen en_US.UTF-8 && \
    locale-gen de_DE.UTF-8 && \
    update-alternatives --set www-browser /usr/bin/lynx && \
    update-alternatives --install /usr/bin/editor editor /usr/bin/micro 100 && \
    curl -o /usr/local/bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy && \
    chmod +x /usr/local/bin/diff-so-fancy && \
    #curl -fsSL https://bun.sh/install | bash - && \ # missing version
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Additional tools installation
RUN curl -fsSL https://raw.githubusercontent.com/ellie/atuin/main/install.sh | bash - && \
    cargo install nu --features=dataframe && \
    cargo install --git https://github.com/Peltoche/lsd.git --branch master && \
    cargo install organize-rt tre-command ripgrep watchexec-cli du-dust tokei starship && \
    curl -o /usr/local/bin/lsicons.py https://raw.githubusercontent.com/tangent-ag/bash-bashing/main/scripts/files/lsicons.py && \
    echo "deb [trusted=yes] https://apt.fury.io/rsteube/ /" >> /etc/apt/sources.list.d/rsteube.list && \
    apt-get update && \
    apt-get -y install carapace-bin && \
    rm -rf "${HOME}/.cargo/registry" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Setup required ARGs
ARG PYTHON_VERSION=3.11
ARG NODEJS_VERSION=18
ARG PNPM_VERSION=8.5.1
ARG BUN_VERSION=0.6.2
ARG POETRY_VERSION=1.4.2

# Python installation
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get -y install python3.11 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    update-alternatives --config python3 && \
    curl -fsSL https://install.python-poetry.org | python3 - --version $POETRY_VERSION && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Node.js installation
RUN curl -fsSL https://deb.nodesource.com/setup_$NODEJS_VERSION.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    npm install -g pnpm@$PNPM_VERSION bun@$BUN_VERSION turbo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TZ=Europe/Berlin \
    EDITOR="/usr/bin/micro" \
    FZF_DEFAULT_COMMAND="/usr/bin/fd" \
    BAT_PAGER="/usr/bin/bat" \
    FD_OPTIONS="--hidden --no-ignore-vcs" \
    DEBIAN_FRONTEND=dialog

# Change default shell to fish
SHELL ["/usr/bin/fish", "-c"]

# Install fisher and plugins
RUN curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && \
    fisher install jorgebucaran/fisher jethrokuan/z decors/fish-colored-man jorgebucaran/autopair.fish \
    nickeb96/puffer-fish jorgebucaran/replay.fish joehillen/to-fish jorgebucaran/fishtape tangent-ag/fzf.fish \
    tangent-ag/fish-fzf-z omochice/fzf-emoji.fish dteoh/fish-direnv daleeidd/natural-selection && \
    curl -fsSL https://raw.githubusercontent.com/tangent-ag/bash-bashing/main/scripts/files/git/setup_git_diff-so-fancy_aliases.sh | bash -

FROM builder

# mount with configs for appending
VOLUME ["/mnt/config"]

# Change default shell to fish
SHELL ["/usr/bin/fish", "-c"]

COPY config/* "$HOME/.config/"
RUN mv -f "$HOME/.config/config.fish" "$HOME/.config/fish/config.fish"
# Append from config mount. To load bun config mount /mnt/config contining .bunfig.toml
RUN test -d "/mnt/config" && fish -c 'for file in /mnt/config/*; if test -f $file; cat "$file" > "$HOME/.config/(basename $file)"; end; end'

# Set workdir to /src
WORKDIR /src
