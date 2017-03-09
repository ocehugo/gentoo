# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit eutils haskell-cabal

DESCRIPTION="Fast, memory-efficient, low-level networking"
HOMEPAGE="https://github.com/tibbe/network-bytestring"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/network-2.2.1.1:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ghc-7.6.patch
	cabal_chdeps \
		'network    >= 2.2.1.1 && < 2.3' 'network    >= 2.2.1.1' \
		'base       < 4.4' 'base'
}
