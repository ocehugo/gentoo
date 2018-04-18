# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd user

DESCRIPTION="serves a fully RESTful API from any existing PostgreSQL database."
HOMEPAGE="https://postgrest.com"
SRC_URI="https://github.com/begriffs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-haskell/stack"
RDEPEND="!dev-db/postgrest-bin
	dev-db/postgresql
"

pkg_setup() {
	enewgroup postgrest
	enewuser postgrest -1 -1 -1  postgrest
}

src_compile() {
	stack build --system-ghc --copy-bins --local-bin-path "${S}" || die
}

src_install() {
	dobin ${PN}
	dodir /etc/${PN}
	insinto /etc/${PN}
	doins "${FILESDIR}/${PN}.conf.sample"
	systemd_newunit "${FILESDIR}/systemd/${PN}.service"  "${PN}@.service"
}
