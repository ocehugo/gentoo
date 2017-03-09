# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A logging system for WAI"
HOMEPAGE="http://hackage.haskell.org/package/wai-logger"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT=test # wai-test cyclic depend

RDEPEND="dev-haskell/auto-update:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	dev-haskell/byteorder:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	>=dev-haskell/easy-file-0.2:=[profile?]
	>=dev-haskell/fast-logger-2.2:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/network:=[profile?]
	>=dev-haskell/unix-time-0.2.2:=[profile?]
	>=dev-haskell/wai-2.0.0:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/doctest )
"
