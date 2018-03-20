# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit fdo-mime gnome2-utils

DESCRIPTION="A panel plug-in with date, time and embedded calender"
HOMEPAGE="https://goodies.xfce.org/projects/panel-plugins/xfce4-datetime-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~arm64 hppa ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=xfce-base/libxfce4ui-4.12:=[gtk3(+)]
	>=xfce-base/xfce4-panel-4.12:="
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS THANKS )

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
