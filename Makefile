# Common prefix for installation directories.
prefix         ?= /usr/local
datarootdir    ?= $(prefix)/share
datadir        ?= $(datarootdir)
exec_prefix    ?= $(prefix)
bindir         ?= $(exec_prefix)/bin
libdir         ?= $(exec_prefix)/lib
libexecdir     ?= $(exec_prefix)/libexec
infodir        ?= $(datarootdir)/info
sysconfdir     ?= $(prefix)/etc
systemdunitdir ?= $(libdir)/systemd/system

# configuration options
ifneq ($(shell command -v systemctl 2>&1),)
HAVE_SYSTEMD   ?= 1
else
HAVE_SYSTEMD   ?= 0
endif

.PHONY: all
all:

.PHONY: install
install:
	install -D -m 755 -t $(bindir) bwd
	install -D -m 644 -t $(sysconfdir) bwd.conf
	@sed -i 's|/etc/bwd.conf|$(shell realpath $(sysconfdir))/bwd.conf|' $(bindir)/bwd

ifeq ($(HAVE_SYSTEMD),1)
	install -D -m 644 -t $(systemdunitdir) bwd.service
	install -D -m 644 -t $(systemdunitdir) bwd.timer
	@sed -i 's|/usr/bin/bwd|$(shell realpath $(bindir))/bwd|' $(systemdunitdir)/bwd.service
endif

.PHONY: uninstall
uninstall:
	$(RM) \
		$(bindir)/bwd \
		$(sysconfdir)/bwd.conf \
		$(systemdunitdir)/bwd.service \
		$(systemdunitdir)/bwd.timer
