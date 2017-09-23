# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Haskell 98 bifunctors, bifoldables and bitraversables"
HOMEPAGE="https://github.com/ekmett/bifunctors/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 x86"
IUSE="+semigroups +tagged"

RDEPEND=">=dev-haskell/base-orphans-0.5.2:=[profile?] <dev-haskell/base-orphans-1:=[profile?]
	>=dev-haskell/comonad-4:=[profile?] <dev-haskell/comonad-6:=[profile?]
	>=dev-haskell/transformers-0.2:=[profile?] <dev-haskell/transformers-0.6:=[profile?]
	>=dev-haskell/transformers-compat-0.5:=[profile?] <dev-haskell/transformers-compat-0.6:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	semigroups? ( >=dev-haskell/semigroups-0.8.3.1:=[profile?] <dev-haskell/semigroups-1:=[profile?] )
	tagged? ( >=dev-haskell/tagged-0.7.3:=[profile?] <dev-haskell/tagged-1:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/hspec-1.8
		>=dev-haskell/quickcheck-2 <dev-haskell/quickcheck-3 )
"

src_prepare() {
	default

	cabal_chdeps \
		'QuickCheck          >= 2   && < 3,' 'QuickCheck          >= 2   && < 3, template-haskell,'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag semigroups semigroups) \
		$(cabal_flag tagged tagged)
}
