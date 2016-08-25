# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MATE_LA_PUNT="yes"

inherit mate

if [[ ${PV} != 9999 ]]; then
	KEYWORDS="~amd64 ~arm ~x86"
fi

DESCRIPTION="Several Caja extensions"
LICENSE="GPL-2"
SLOT="0"

SENDTO="cdr gajim +mail pidgin upnp"
IUSE="gksu gtk3 image-converter +open-terminal share +wallpaper ${SENDTO}"

RDEPEND=">=dev-libs/glib-2.36:2
	>=mate-base/caja-1.7[gtk3(-)=]
	virtual/libintl:0
	x11-libs/gdk-pixbuf:2
	cdr? ( >=app-cdr/brasero-2.32.1:0= )
	gajim? (
		net-im/gajim:0
		>=dev-libs/dbus-glib-0.60:0
		>=sys-apps/dbus-1:0
	)
	gksu? ( x11-libs/gksu )
	!gtk3? ( >=x11-libs/gtk+-2.24:2 )
	gtk3? ( >=x11-libs/gtk+-3.0:3 )
	image-converter? (
		|| (
			media-gfx/imagemagick
			media-gfx/graphicsmagick[imagemagick]
		)
	)
	open-terminal? ( >=mate-base/mate-desktop-1.7[gtk3(-)=] )
	pidgin? ( >=dev-libs/dbus-glib-0.60:0 )
	upnp? ( >=net-libs/gupnp-0.13:0= )"

DEPEND="${RDEPEND}
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.18:*
	sys-devel/gettext:*
	virtual/pkgconfig:*
	!!mate-extra/mate-file-manager-open-terminal
	!!mate-extra/mate-file-manager-sendto
	!!mate-extra/mate-file-manager-image-converter
	!!mate-extra/mate-file-manager-share"

src_configure() {
	local sendto_plugins="removable-devices"
	use cdr && sendto_plugins+=",caja-burn"
	use mail && sendto_plugins+=",emailclient"
	use pidgin && sendto_plugins+=",pidgin"
	use gajim && sendto_plugins+=",gajim"
	use upnp && sendto_plugins+=",upnp"

	mate_src_configure \
		--enable-sendto \
		--with-sendto-plugins=${sendto_plugins}\
		--with-gtk=$(usex gtk3 3.0 2.0) \
		$(use_enable gksu) \
		$(use_enable image-converter) \
		$(use_enable open-terminal) \
		$(use_enable share) \
		$(use_enable wallpaper)
}
