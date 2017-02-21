# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=3

inherit eutils flag-o-matic autotools prefix

CONFVER="1.8"

MY_P="${P}.00"
DESCRIPTION="Enhanced version of the Berkeley C shell (csh)"
HOMEPAGE="http://www.tcsh.org/"
SRC_URI="ftp://ftp.astron.com/pub/tcsh/old/${MY_P}.tar.gz
	https://www.gentoo.org/~grobian/distfiles/tcsh-gentoo-patches-r${CONFVER}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="m68k"
IUSE="catalogs doc"
RESTRICT="test"

# we need gettext because we run autoconf (AM_ICONV)
RDEPEND=">=sys-libs/ncurses-5.1
	virtual/libiconv"
DEPEND="${RDEPEND}
	sys-devel/gettext
	doc? ( dev-lang/perl )"

S=${WORKDIR}/${MY_P}
CONFDIR=${WORKDIR}/tcsh-gentoo-patches-r${CONFVER}

src_prepare() {
	epatch "${FILESDIR}/${MY_P/17/14}"-debian-dircolors.patch # bug #120792
	epatch "${FILESDIR}"/${PN}-6.14-makefile.patch # bug #151951
	epatch "${FILESDIR}"/${PN}-6.14-use-ncurses.patch
	eautoreconf

	if use catalogs ; then
		einfo "enabling NLS catalogs support..."
		sed -i -e "s/#undef NLS_CATALOGS/#define NLS_CATALOGS/" \
			config_f.h || die
		eend $?
	fi

	# unify ECHO behaviour
	echo "#undef ECHO_STYLE" >> config_f.h
	echo "#define ECHO_STYLE      BOTH_ECHO" >> config_f.h

	eprefixify "${CONFDIR}"/*
	# activate the right default PATH
	if [[ -z ${EPREFIX} ]] ; then
		sed -i \
			-e 's/^#MAIN//' -e '/^#PREFIX/d' \
			"${CONFDIR}"/csh.login || die
	else
		sed -i \
			-e 's/^#PREFIX//' -e '/^#MAIN/d' \
			"${CONFDIR}"/csh.login || die
	fi
}

src_configure() {
	# make tcsh look and live along the lines of the prefix
	append-flags -D_PATH_DOTCSHRC="'"'"${EPREFIX}/etc/csh.cshrc"'"'"
	append-flags -D_PATH_DOTLOGIN="'"'"${EPREFIX}/etc/csh.login"'"'"
	append-flags -D_PATH_DOTLOGOUT="'"'"${EPREFIX}/etc/csh.logout"'"'"
	append-flags -D_PATH_USRBIN="'"'"${EPREFIX}/usr/bin"'"'"
	append-flags -D_PATH_BIN="'"'"${EPREFIX}/bin"'"'"

	econf \
		--prefix="${EPREFIX:-/}" \
		--datarootdir='${prefix}/usr/share'
}

src_install() {
	emake DESTDIR="${D}" install install.man || die

	if use doc ; then
		perl tcsh.man2html tcsh.man || die
		dohtml tcsh.html/*.html
	fi

	insinto /etc
	doins \
		"${CONFDIR}"/csh.cshrc \
		"${CONFDIR}"/csh.login

	dodoc FAQ Fixes NewThings Ported README WishList Y2K

	# bug #119703: add csh -> tcsh symlink
	dosym /bin/tcsh /bin/csh
}
