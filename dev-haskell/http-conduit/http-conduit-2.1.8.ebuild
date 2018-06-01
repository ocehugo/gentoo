# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="HTTP client package with conduit interface and HTTPS support"
HOMEPAGE="https://www.yesodweb.com/book/http-conduit"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/conduit-0.5.5:=[profile?] <dev-haskell/conduit-1.3:=[profile?]
	>=dev-haskell/http-client-0.4.19:=[profile?] <dev-haskell/http-client-0.5:=[profile?]
	>=dev-haskell/http-client-tls-0.2.2:=[profile?]
	>=dev-haskell/http-types-0.7:=[profile?]
	>=dev-haskell/lifted-base-0.1:=[profile?]
	dev-haskell/monad-control:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/resourcet-1.1:=[profile?] <dev-haskell/resourcet-1.2:=[profile?]
	>=dev-haskell/transformers-0.2:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( dev-haskell/blaze-builder
		dev-haskell/case-insensitive
		>=dev-haskell/conduit-1.1
		dev-haskell/conduit-extra
		>=dev-haskell/connection-0.2
		dev-haskell/cookie
		dev-haskell/data-default-class
		>=dev-haskell/hspec-1.3
		dev-haskell/hunit
		dev-haskell/network
		dev-haskell/streaming-commons
		dev-haskell/text
		dev-haskell/utf8-string
		>=dev-haskell/wai-3.0 <dev-haskell/wai-3.1
		dev-haskell/wai-conduit
		>=dev-haskell/warp-3.0.0.2 <dev-haskell/warp-3.2
		dev-haskell/warp-tls )
"
