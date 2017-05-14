# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit autotools eutils multilib user python-single-r1

DESCRIPTION="Network traffic analyzer with web interface"
HOMEPAGE="http://www.ntop.org/products/ntop/"
SRC_URI="mirror://sourceforge/ntop/ntop/Stable/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="libressl snmp ssl"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	dev-lang/lua:=
	dev-lang/perl
	dev-libs/geoip
	dev-libs/libevent
	media-libs/gd
	media-libs/libpng:0=
	net-analyzer/rrdtool[graph]
	net-libs/libpcap
	snmp? ( net-analyzer/net-snmp[ipv6] )
	ssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:0= )
	)
	sys-libs/gdbm
	sys-libs/zlib
	virtual/awk
	${PYTHON_DEPS}
"
DEPEND="
	${COMMON_DEPEND}
	>=sys-devel/libtool-1.5.26
"
RDEPEND="
	${COMMON_DEPEND}
	app-arch/gzip
	dev-libs/glib:2
	dev-python/mako
	media-gfx/graphviz
	net-misc/wget
"

pkg_setup() {
	enewgroup ntop
	enewuser ntop -1 -1 /var/lib/ntop ntop
	python-single-r1_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-includes.patch \
		"${FILESDIR}"/${P}-librrd.patch

	cp /usr/share/aclocal/libtool.m4 libtool.m4.in
	cat acinclude.m4.in libtool.m4.in acinclude.m4.ntop > acinclude.m4
	eautoreconf

	# The build system is a complete mess, so apply a configure patch here
	# instead of patching configure.in above
	epatch "${FILESDIR}"/${P}-INCS.patch

	# Stop make from doing autotools stuff
	sed -i -e '/missing --run echo/s|=.*|= true|g' Makefile.in || die
}

src_configure() {
	export \
		ac_cv_header_glib_h=no \
		ac_cv_header_glibconfig_h=no \
		ac_cv_header_gdome_h=no \
		ac_cv_lib_glib_g_date_julian=no \
		ac_cv_lib_xml2_xmlCheckVersion=no \
		ac_cv_lib_gdome_gdome_di_saveDocToFile=no

	pushd nDPI >/dev/null || die
	econf
	popd &>/dev/null || die

	if has_version '<net-analyzer/rrdtool-1.6'; then
		export RRD_LIB=-lrrd_th
	else
		export RRD_LIB=-lrrd
	fi

	econf \
		$(use_enable snmp) \
		$(use_with ssl) \
		--with-rrd-home=/usr/$(get_libdir)
}

src_compile() {
	pushd nDPI >/dev/null || die
	emake
	popd &>/dev/null || die

	emake
}

src_install() {
	LC_ALL=C # apparently doesn't work with some locales (#191576 and #205382)

	emake DESTDIR="${D}" install

	keepdir /var/lib/ntop

	insinto /var/lib/ntop
	gunzip 3rd_party/GeoIPASNum.dat.gz
	gunzip 3rd_party/GeoLiteCity.dat.gz
	local f
	for f in GeoIPASNum.dat GeoLiteCity.dat; do
		# Don't install included GeoIP files if newer versions are available
		[ -f "${ROOT}/var/lib/ntop/${f}" ] ||
			doins "3rd_party/${f}"
	done

	dodoc AUTHORS CONTENTS ChangeLog MANIFESTO NEWS
	dodoc PORTING README SUPPORT_NTOP.txt THANKS $(find docs -type f)

	newinitd "${FILESDIR}"/ntop-initd-r1 ntop
	newconfd "${FILESDIR}"/ntop-confd ntop

	exeinto /etc/cron.monthly
	doexe "${FILESDIR}"/ntop-update-geoip-db
}

pkg_postinst() {
	fowners ntop:ntop /var/lib/ntop
	fperms 750 /var/lib/ntop
}
