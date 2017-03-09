# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Attoparsec parsers for http-types"
HOMEPAGE="https://github.com/tlaitinen/http-attoparsec"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/attoparsec-0.10.4.0:=[profile?]
	>=dev-haskell/http-types-0.8.0:=[profile?]
	>=dev-lang/ghc-6.12.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8.0.2
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-http.patch

	cabal_chdeps \
		'attoparsec >= 0.10.4.0 && < 0.12' 'attoparsec >= 0.10.4.0' \
		'http-types >= 0.8.0 && < 0.9' 'http-types >= 0.8.0'
}
