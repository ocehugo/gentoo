# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
GNOME2_LA_PUNT="yes"
GNOME_ORG_MODULE="network-manager-applet"

inherit gnome2

DESCRIPTION="GNOME applet for NetworkManager"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"

LICENSE="GPL-2+"
SLOT="0"
IUSE="+introspection +gcr +modemmanager selinux teamd"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="
	>=app-crypt/libsecret-0.18
	>=dev-libs/glib-2.38:2[dbus]
	>=dev-libs/dbus-glib-0.88
	>=sys-apps/dbus-1.4.1
	>=sys-auth/polkit-0.96-r1
	>=x11-libs/gtk+-3.10:3[introspection?]
	>=x11-libs/libnotify-0.7.0

	app-text/iso-codes
	>=net-misc/networkmanager-1.7:=[introspection?,modemmanager?,teamd?]
	net-misc/mobile-broadband-provider-info

	introspection? ( >=dev-libs/gobject-introspection-0.9.6:= )
	virtual/freedesktop-icon-theme
	virtual/libgudev:=
	gcr? ( >=app-crypt/gcr-3.14:=[gtk] )
	modemmanager? ( net-misc/modemmanager )
	selinux? ( sys-libs/libselinux )
	teamd? ( >=dev-libs/jansson-2.7 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.0
	>=dev-util/intltool-0.50.1
	virtual/pkgconfig
"

PDEPEND="virtual/notification-daemon" #546134

PATCHES=(
	# shared/compat: fix memory handling of nm_setting_vpn_get_*_keys
	# (from 'master')
	"${FILESDIR}"/${P}-vpn-crash.patch

	# libnma/cert-chooser: handle case of no avalable modules (from
	# 'master')
	"${FILESDIR}"/${P}-cert-chooser.patch
)

src_configure() {
	local myconf=(
		--without-appindicator
		--disable-lto
		--disable-ld-gc
		--disable-more-warnings
		--disable-static
		--localstatedir=/var
		$(use_enable introspection)
		$(use_with gcr)
		$(use_with modemmanager wwan)
		$(use_with selinux)
		$(use_with teamd team)
	)
	gnome2_src_configure "${myconf[@]}"
}
