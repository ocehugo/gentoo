# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Orphan Instances for 'Data.Vector'"
HOMEPAGE="https://github.com/ekmett/vector-instances"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/comonad-3:=[profile?]
	>=dev-haskell/keys-3:=[profile?]
	>=dev-haskell/pointed-3:=[profile?]
	>=dev-haskell/semigroupoids-3:=[profile?]
	>=dev-haskell/semigroups-0.8.3.1:=[profile?]
	>=dev-haskell/vector-0.9:=[profile?] <dev-haskell/vector-0.12:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"
