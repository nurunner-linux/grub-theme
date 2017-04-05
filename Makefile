Version=17.0.1

PREFIX = /usr/local

CFG = $(wildcard cfg/*.cfg)

MTHEME = \
	$(wildcard nurunner-live/*.png) \
	nurunner-live/theme.txt \
	nurunner-live/u_vga16_16.pf2

MICONS= $(wildcard nurunner-live/icons/*.png)

TZ = $(wildcard tz/*)

LOCALES = $(wildcard locales/*)


install_common:
	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/cfg
	install -m0644 ${CFG} $(DESTDIR)$(PREFIX)/share/grub/cfg

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/tz
	install -m0644 ${TZ} $(DESTDIR)$(PREFIX)/share/grub/tz

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/locales
	install -m0644 ${LOCALES} $(DESTDIR)$(PREFIX)/share/grub/locales

uninstall_common:
	for f in ${CFG}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/cfg/$$f; done
	for f in ${TZ}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/tz/$$f; done
	for f in ${LOCALES}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/locales/$$f; done

install_manjaro:
	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/themes/nurunner-live
	install -m0644 ${MTHEME} $(DESTDIR)$(PREFIX)/share/grub/themes/nurunner-live

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/themes/nurunner-live/icons
	install -m0644 ${MICONS} $(DESTDIR)$(PREFIX)/share/grub/themes/nurunner-live/icons

uninstall_manjaro:
	for f in ${MTHEME}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/theme/nurunner-live/$$f; done
	for f in ${MICONS}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/theme/nurunner-live/icons/$$f; done



install: install_common install_manjaro

uninstall: uninstall_common uninstall_manjaro 

dist:
	git archive --format=tar --prefix=grub-theme-$(Version)/ $(Version) | gzip -9 > grub-theme-$(Version).tar.gz
	gpg --detach-sign --use-agent grub-theme-$(Version).tar.gz

.PHONY: install uninstall dist
