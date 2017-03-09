# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.6

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="HDBC-sqlite3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Sqlite v3 driver for HDBC"
HOMEPAGE="https://github.com/hdbc/hdbc-sqlite3"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-db/sqlite-3.0
	>=dev-haskell/hdbc-2.3.0.0:2=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.2.3
	test? ( dev-haskell/convertible:=[profile?]
			dev-haskell/hunit:=[profile?]
			dev-haskell/old-locale:=[profile?]
			dev-haskell/old-time:=[profile?]
			dev-haskell/testpack:=[profile?] )
"

S="${WORKDIR}/${MY_P}"

# The test suite doesn't work right now. See
#
#   https://github.com/hdbc/hdbc-sqlite3/pull/17
#
RESTRICT="test"
