# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools

DESCRIPTION="MPI library for algorithmic differentiation"
HOMEPAGE="http://www.mcs.anl.gov/~utke/AdjoinableMPI/AdjoinableMPIDox/index.html"
SRC_URI="https://dev.gentoo.org/~jauhien/distfiles/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc64 ~x86"

RDEPEND="virtual/mpi"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}
