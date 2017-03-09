# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

MY_PN="ShellCheck"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Shell script analysis tool"
HOMEPAGE="http://www.shellcheck.net/"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/json:=[profile?]
	>=dev-haskell/mtl-2.2.1:=[profile?]
	dev-haskell/parsec:=[profile?]
	>=dev-haskell/quickcheck-2.7.4:2=[template_haskell,profile?]
	dev-haskell/regex-tdfa:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"

S="${WORKDIR}/${MY_P}"

src_install() {
	cabal_src_install
	doman "${PN}.1"
}
