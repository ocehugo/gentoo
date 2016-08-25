# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MY_PN="${PN}-src"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Combine interpreter of esoteric languages"
HOMEPAGE="http://esco.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="gmp l10n_ru"

DEPEND="gmp? ( dev-libs/gmp:0 )"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog README TODO docs/basics.txt )

src_configure() {
	econf $(use_with gmp)
}

src_install() {
	default
	use l10n_ru && dodoc docs/README_RU.utf8
}
