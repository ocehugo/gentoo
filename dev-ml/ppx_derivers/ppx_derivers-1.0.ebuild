# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit opam

DESCRIPTION="Shared [@@deriving] plugin registry"
HOMEPAGE="https://github.com/diml/ppx_derivers"
SRC_URI="https://github.com/diml/ppx_derivers/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-ml/jbuilder"
