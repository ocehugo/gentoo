# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_AUTODEPS="false"
KDE_DEBUG="false"
inherit kde5

DESCRIPTION="Breeze SVG icon theme"
LICENSE="LGPL-3"
KEYWORDS="amd64 ~arm x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep extra-cmake-modules)
	$(add_qt_dep qtcore)
	test? (
		$(add_qt_dep qttest)
		app-misc/fdupes
	)
"
RDEPEND="!<kde-plasma/breeze-5.4.3:5"

src_configure() {
	local mycmakeargs=(
		-DBINARY_ICONS_RESOURCE=OFF
	)
	kde5_src_configure
}
