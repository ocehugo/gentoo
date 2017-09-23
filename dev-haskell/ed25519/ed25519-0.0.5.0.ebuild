# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.4.6.9999
#hackport: flags: +no-donna,+test-doctests,+test-properties,-test-hlint

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Ed25519 cryptographic signatures"
HOMEPAGE="http://thoughtpolice.github.com/hs-ed25519"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( >=dev-haskell/doctest-0.10
		>=dev-haskell/quickcheck-2.4 )
"

src_prepare() {
	default

	cabal_chdeps \
		'ghc-prim    >= 0.1 && < 0.5' 'ghc-prim    >= 0.1' \
		'doctest   >= 0.10 && < 0.11' 'doctest   >= 0.10' \
		'QuickCheck  >= 2.4 && < 2.9' 'QuickCheck  >= 2.4' \
		'directory >= 1.0  && < 1.3' 'directory >= 1.0'
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=no-donna \
		--flag=test-doctests \
		--flag=-test-hlint \
		--flag=test-properties
}
