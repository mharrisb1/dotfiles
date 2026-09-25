# dotfiles

Resources for minimal setup for new Linux machines (primarily Ubuntu, RHEL, and Debian). I often work across machines where I am limited to what I can install.

## Install Packages

### Debian/Ubuntu

```bash
sudo apt install -y $(cat .packages)
```

### RHEL

```bash
sudo dnf install -y $(cat .packages)
```

## Uninstall Packages

### Debian/Ubuntu

```bash
sudo apt remove -y $(cat .packages)
```

### RHEL

```bash
sudo dnf remove -y $(cat .packages)
```

## Scripts

```bash
chmod -R +x bin/
```

### Setup

```bash
./bin/setup.sh
```

### Teardown

```bash
./bin/teardown.sh
```

