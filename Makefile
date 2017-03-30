Version=17.0.1

PREFIX = /usr/local

CFG = $(wildcard cfg/*.cfg)

THEME = $(wildcard nurunner-live/*.png) \
	nurunner-live/theme.txt \
	nurunner-live/u_vga16_16.pf2

ICONS= $(wildcard nurunner-live/icons/*.png)

TZ = $(wildcard tz/*)

LOCALES = $(wildcard locales/*)

VIDEO = $(wildcard video/*)

install:
	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/cfg
	install -m0644 ${CFG} $(DESTDIR)$(PREFIX)/share/grub/cfg

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/tz
	install -m0644 ${TZ} $(DESTDIR)$(PREFIX)/share/grub/tz

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/locales
	install -m0644 ${LOCALES} $(DESTDIR)$(PREFIX)/share/grub/locales

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/video
	install -m0644 ${VIDEO} $(DESTDIR)$(PREFIX)/share/grub/video

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/themes/nurunner-live
	install -m0644 ${THEME} $(DESTDIR)$(PREFIX)/share/grub/themes/nurunner-live

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/themes/nurunner-live/icons
	install -m0644 ${ICONS} $(DESTDIR)$(PREFIX)/share/grub/themes/nurunner-live/icons

uninstall:
	for f in ${CFG}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/cfg/$$f; done
	for f in ${TZ}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/tz/$$f; done
	for f in ${LOCALES}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/locales/$$f; done
	for f in ${VIDEO}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/video/$$f; done
	for f in ${THEME}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/theme/nurunner-live/$$f; done
	for f in ${ICONS}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/theme/nurunner-live/icons/$$f; done

dist:
	git archive --format=tar --prefix=grub-theme-$(Version)/ $(Version) | gzip -9 > grub-theme-$(Version).tar.gz
	gpg --detach-sign --use-agent grub-theme-$(Version).tar.gz

.PHONY: install uninstall dist
