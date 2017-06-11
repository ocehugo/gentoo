# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR=BTROTT
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Read/write encrypted ASN.1 PEM files"

SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ~ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="
	dev-perl/Class-ErrorHandler
	dev-perl/Convert-ASN1
	dev-perl/Crypt-DES_EDE3
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64
"
DEPEND="${RDEPEND}"

SRC_TEST=do

src_prepare() {
	sed -i -e 's/use inc::Module::Install;/use lib q[.]; use inc::Module::Install;/' Makefile.PL ||
		die "Can't patch Makefile.PL for 5.26 dot-in-inc"
	perl-module_src_prepare
}
