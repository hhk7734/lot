# lot

## Installation

### PPA

```bash
sudo add-apt-repository -y ppa:loliot/ppa \
&& sudo apt update
```

```bash
sudo apt install lot
```

### Manual

```bash
git clone https://github.com/loliot/lot.git \
&& cd lot \
&& sudo make install \
&& sudo make gm \
&& cd .. && sudo rm -rf lot
```

## Structure

```bash
/etc/udev/rules.d
├── 51-lot.rules
/usr/bin
├── lot
├── lot-config
/usr/lib/lot
├── detect_device.sh
├── ...
/var/lib/lot
├── (lock)
├── lists
│   ├── lot
│   │   ├── debian/changelog
│   │   └── Makefile
│   └── ...
└── ...
```
