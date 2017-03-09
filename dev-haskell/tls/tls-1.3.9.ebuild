# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="TLS/SSL protocol native implementation (Server and Client)"
HOMEPAGE="https://github.com/vincenthz/hs-tls"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+compat +network"

RDEPEND="dev-haskell/asn1-encoding:=[profile?]
	>=dev-haskell/asn1-types-0.2.0:=[profile?]
	dev-haskell/async:=[profile?]
	>=dev-haskell/cereal-0.4:=[profile?]
	>=dev-haskell/cryptonite-0.21:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	dev-haskell/memory:=[profile?]
	>=dev-haskell/mtl-2:=[profile?]
	>=dev-haskell/x509-1.6.5:=[profile?] <dev-haskell/x509-1.7.0:=[profile?]
	>=dev-haskell/x509-store-1.6:=[profile?]
	>=dev-haskell/x509-validation-1.6.5:=[profile?] <dev-haskell/x509-validation-1.7.0:=[profile?]
	>=dev-lang/ghc-7.8.2:=
	network? ( dev-haskell/network:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( dev-haskell/hourglass
		dev-haskell/quickcheck
		dev-haskell/tasty
		dev-haskell/tasty-quickcheck )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag compat compat) \
		$(cabal_flag network network)
}
