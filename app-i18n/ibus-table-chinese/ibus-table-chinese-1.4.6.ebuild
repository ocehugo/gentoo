# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
CMAKE_IN_SOURCE_BUILD="1"

inherit cmake-utils

MY_P="${P}-Source"

DESCRIPTION="Chinese tables for IBus-Table"
HOMEPAGE="https://github.com/definite/ibus-table-chinese"
SRC_URI="https://ibus.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-i18n/ibus-table"
DEPEND="${RDEPEND}
	dev-util/cmake-fedora"
S="${WORKDIR}/${MY_P}"
