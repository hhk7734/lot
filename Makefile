# MIT License
# 
# Copyright (c) 2020 Hyeonki Hong <hhk7734@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

prefix = /usr

rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

ifeq ($(strip ${SUDO_USER}),)
	SUDO_USER=${USER}
endif

.PHONY: all
all:
	@:

.PHONY: install
install:
	install -m 0755 -d $(DESTDIR)/etc/udev/rules.d
	install -m 0755 -d $(DESTDIR)$(prefix)/bin
	install -m 0755 -d $(DESTDIR)$(prefix)/lib/lot
	install -m 0755 -d $(DESTDIR)/var/lib/lot/lists/lot/debian
	install -m 0644 51-lot.rules $(DESTDIR)/etc/udev/rules.d
	install -m 0755 lot lot-config $(DESTDIR)$(prefix)/bin
	install -m 0644 $(call rwildcard,scripts,*.sh) $(DESTDIR)$(prefix)/lib/lot
	install -m 0644 debian/changelog $(DESTDIR)/var/lib/lot/lists/lot/debian
	install -m 0755 Makefile $(DESTDIR)/var/lib/lot/lists/lot

.PHONY: clean
clean:

.PHONY: distclean
distclean: clean

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)/etc/udev/rules.d/51-lot.rules
	rm -f $(DESTDIR)$(prefix)/bin/lot
	rm -f $(DESTDIR)$(prefix)/bin/lot-config
	rm -rf $(DESTDIR)$(prefix)/lib/lot
	whiptail --yesno "Would you like to remove lot-lists?" 20 60 \
	&& rm -rf $(DESTDIR)/var/lib/lot \
	|| rm -rf $(DESTDIR)/var/lib/lot/lists/lot

# shellcheck
.PHONY: sc
sc:
	shellcheck scripts/* lot lot-config

# group management
.PHONY: gm
gm:
	grep -q dialout: /etc/group || addgroup dialout \
	&& (groups ${SUDO_USER} | grep -q dialout || usermod -aG dialout ${SUDO_USER})
	grep -q spi: /etc/group || addgroup spi \
	&& (groups ${SUDO_USER} | grep -q spi || usermod -aG spi ${SUDO_USER})
	grep -q i2c: /etc/group || addgroup i2c \
	&& (groups ${SUDO_USER} | grep -q i2c || usermod -aG i2c ${SUDO_USER})
