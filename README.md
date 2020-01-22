# lot

## Installation

```bash
sudo add-apt-repository -y ppa:loliot/ppa &&\
sudo apt update
```

```bash
sudo apt install lot
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
