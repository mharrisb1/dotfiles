# dotfiles

Resources for minimal setup for new Linux machines (primarily Ubuntu, RHEL, and Debian).

## Package Management

### Debian/Ubuntu

```bash
sudo apt install -y $(cat .packages)
# or
sudo apt remove -y $(cat .packages)
```

### RHEL

```bash
sudo dnf install -y $(cat .packages)
# or
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

