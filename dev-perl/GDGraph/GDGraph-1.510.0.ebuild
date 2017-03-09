# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=RUZ
DIST_VERSION=1.51
inherit perl-module

DESCRIPTION="Perl5 module to create charts using the GD module"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/GD-1.180.0
	>=dev-perl/GDTextUtil-0.800.0
	media-libs/gd
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.640.0
	test? (
		>=dev-perl/Capture-Tiny-0.300.0
		>=dev-perl/Test-Exception-0.400.0
		>=virtual/perl-Test-Simple-0.880.0
	)
"
