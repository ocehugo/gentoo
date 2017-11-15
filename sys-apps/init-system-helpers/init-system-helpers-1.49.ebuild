# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Helper scripts useful for both OpenRC and systemd"
HOMEPAGE="https://packages.debian.org/sid/init-system-helpers"
# git repo: https://anonscm.debian.org/git/collab-maint/init-system-helpers.git
SRC_URI="http://http.debian.net/debian/pool/main/i/${PN}/${PN}_${PV}.tar.xz"

LICENSE="BSD GPL-2+"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND="!<sys-apps/openrc-0.33"

src_install() {
	# We only care about 'service' script/manpage:
	exeinto /sbin/
	doexe script/service

	# FIXME: need to patch to remove *rc.d references, which we don't ship
	# And should probably add a list of supported options (e.g., start/stop/etc.)
	doman man8/service.8
}
