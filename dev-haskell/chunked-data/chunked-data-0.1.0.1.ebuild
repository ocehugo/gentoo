# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Typeclasses for dealing with various chunked data representations"
HOMEPAGE="https://github.com/fpco/chunked-data"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/blaze-builder:=[profile?]
	>=dev-haskell/mono-traversable-0.2:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/system-filepath:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	dev-haskell/transformers:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-6.10.4:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"
