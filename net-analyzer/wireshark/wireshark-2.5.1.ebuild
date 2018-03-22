# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils fcaps flag-o-matic gnome2-utils multilib qmake-utils user xdg-utils

DESCRIPTION="A network protocol analyzer formerly known as ethereal"
HOMEPAGE="https://www.wireshark.org/"
SRC_URI="${HOMEPAGE}download/src/all-versions/${P/_/}.tar.xz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc64 ~x86"
IUSE="
	adns androiddump bcg729 +capinfos +caps +captype ciscodump
	cpu_flags_x86_sse4_2 +dftest doc +dumpcap +editcap gtk kerberos libssh
	libxml2 lua lz4 maxminddb +mergecap +netlink nghttp2 +pcap portaudio +qt5
	+randpkt +randpktdump +reordercap sbc selinux +sharkd smi snappy spandsp
	sshdump ssl +text2pcap tfshark +tshark +udpdump zlib
"
REQUIRED_USE="
	ciscodump? ( libssh )
	sshdump? ( libssh )
"

S=${WORKDIR}/${P/_/}

CDEPEND="
	>=dev-libs/glib-2.14:2
	dev-libs/libgcrypt:0
	netlink? ( dev-libs/libnl:3 )
	adns? ( >=net-dns/c-ares-1.5 )
	bcg729? ( media-libs/bcg729 )
	caps? ( sys-libs/libcap )
	gtk? (
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:3
		x11-libs/pango
		x11-misc/xdg-utils
	)
	kerberos? ( virtual/krb5 )
	libssh? ( >=net-libs/libssh-0.6 )
	libxml2? ( dev-libs/libxml2 )
	lua? ( >=dev-lang/lua-5.1:* )
	lz4? ( app-arch/lz4 )
	maxminddb? ( dev-libs/libmaxminddb )
	nghttp2? ( net-libs/nghttp2 )
	pcap? ( net-libs/libpcap )
	portaudio? ( media-libs/portaudio )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtmultimedia:5
		dev-qt/qtprintsupport:5
		dev-qt/qtwidgets:5
		|| (
			media-libs/speexdsp
			<media-libs/speex-1.2.0
		)
		x11-misc/xdg-utils
	)
	sbc? ( media-libs/sbc )
	smi? ( net-libs/libsmi )
	snappy? ( app-arch/snappy )
	spandsp? ( media-libs/spandsp )
	ssl? ( net-libs/gnutls:= )
	zlib? ( sys-libs/zlib !=sys-libs/zlib-1.2.4 )
"
# We need perl for `pod2html`.  The rest of the perl stuff is to block older
# and broken installs. #455122
DEPEND="
	${CDEPEND}
	dev-lang/perl
	!<virtual/perl-Pod-Simple-3.170
	!<perl-core/Pod-Simple-3.170
	doc? (
		app-doc/doxygen
		dev-ruby/asciidoctor
	)
	qt5? (
		dev-qt/linguist-tools:5
	)
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"
RDEPEND="
	${CDEPEND}
	gtk? ( virtual/freedesktop-icon-theme )
	qt5? ( virtual/freedesktop-icon-theme )
	selinux? ( sec-policy/selinux-wireshark )
"
PATCHES=(
	"${FILESDIR}"/${PN}-1.99.8-qtchooser.patch
	"${FILESDIR}"/${PN}-2.1.0-sse4_2-r1.patch
	"${FILESDIR}"/${PN}-2.4-androiddump.patch
	"${FILESDIR}"/${PN}-99999999-androiddump.patch
)

pkg_setup() {
	enewgroup wireshark
}

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	local myconf

	# Workaround bug #213705. If krb5-config --libs has -lcrypto then pass
	# --with-ssl to ./configure. (Mimics code from acinclude.m4).
	if use kerberos; then
		case $(krb5-config --libs) in
			*-lcrypto*)
				ewarn "Kerberos was built with ssl support: linkage with openssl is enabled."
				ewarn "Note there are annoying license incompatibilities between the OpenSSL"
				ewarn "license and the GPL, so do your check before distributing such package."
				myconf+=( "--with-ssl" )
				;;
		esac
	fi

	# Enable wireshark binary with any supported GUI toolkit (bug #473188)
	if use gtk || use qt5; then
		myconf+=( "--enable-wireshark" )
	else
		myconf+=( "--disable-wireshark" )
	fi

	if ! use qt5; then
		myconf+=( "--with-qt=no" )
	fi

	if use qt5; then
		export QT_MIN_VERSION=5.3.0
		append-cxxflags -fPIC -DPIC
	fi

	econf \
		$(use androiddump && use pcap && echo --enable-androiddump-use-libpcap=yes) \
		$(use dumpcap && use_with pcap dumpcap-group wireshark) \
		$(use_enable androiddump) \
		$(use_enable capinfos) \
		$(use_enable captype) \
		$(use_enable ciscodump) \
		$(use_enable dftest) \
		$(use_enable doc guides) \
		$(use_enable dumpcap) \
		$(use_enable editcap) \
		$(use_enable mergecap) \
		$(use_enable randpkt) \
		$(use_enable randpktdump) \
		$(use_enable reordercap) \
		$(use_enable sharkd) \
		$(use_enable sshdump) \
		$(use_enable text2pcap) \
		$(use_enable tfshark) \
		$(use_enable tshark) \
		$(use_enable udpdump) \
		$(use_with adns c-ares) \
		$(use_with bcg729) \
		$(use_with caps libcap) \
		$(use_with gtk gtk 3) \
		$(use_with kerberos krb5) \
		$(use_with libssh) \
		$(use_with libxml2) \
		$(use_with lua) \
		$(use_with lz4) \
		$(use_with maxminddb) \
		$(use_with nghttp2) \
		$(use_with pcap) \
		$(use_with portaudio) \
		$(use_with sbc) \
		$(use_with smi libsmi) \
		$(use_with snappy) \
		$(use_with spandsp) \
		$(use_with ssl gnutls) \
		$(use_with zlib) \
		$(usex cpu_flags_x86_sse4_2 --enable-sse4_2 '') \
		$(usex netlink --with-libnl=3 --without-libnl) \
		$(usex qt5 --with-qt=5 '') \
		$(usex qt5 LRELEASE=$(qt5_get_bindir)/lrelease '') \
		$(usex qt5 MOC=$(qt5_get_bindir)/moc '') \
		$(usex qt5 RCC=$(qt5_get_bindir)/rcc '') \
		$(usex qt5 UIC=$(qt5_get_bindir)/uic '') \
		--disable-warnings-as-errors \
		--sysconfdir="${EPREFIX}"/etc/wireshark \
		${myconf[@]}
}

src_install() {
	default

	# FAQ is not required as is installed from help/faq.txt
	dodoc AUTHORS ChangeLog NEWS README* doc/randpkt.txt doc/README*

	# install headers
	local wsheader
	for wsheader in \
		config.h \
		epan/*.h \
		epan/crypt/*.h \
		epan/dfilter/*.h \
		epan/dissectors/*.h \
		epan/ftypes/*.h \
		epan/wmem/*.h \
		wiretap/*.h \
		ws_diag_control.h \
		ws_symbol_export.h \
		wsutil/*.h
	do
		insinto /usr/include/wireshark/$( dirname ${wsheader} )
		doins ${wsheader}
	done

	#with the above this really shouldn't be needed, but things may be looking in wiretap/ instead of wireshark/wiretap/
	insinto /usr/include/wiretap
	doins wiretap/wtap.h

	if use gtk || use qt5; then
		local s
		for s in 16 32 48 64 128 256 512 1024; do
			insinto /usr/share/icons/hicolor/${s}x${s}/apps
			newins image/wsicon${s}.png wireshark.png
		done
		for s in 16 24 32 48 64 128 256 ; do
			insinto /usr/share/icons/hicolor/${s}x${s}/mimetypes
			newins image/WiresharkDoc-${s}.png application-vnd.tcpdump.pcap.png
		done
	fi

	prune_libtool_files
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

	# Add group for users allowed to sniff.
	enewgroup wireshark

	if use dumpcap && use pcap; then
		fcaps -o 0 -g wireshark -m 4710 -M 0710 \
			cap_dac_read_search,cap_net_raw,cap_net_admin \
			"${EROOT}"/usr/bin/dumpcap
	fi

	ewarn "NOTE: To capture traffic with wireshark as normal user you have to"
	ewarn "add yourself to the wireshark group. This security measure ensures"
	ewarn "that only trusted users are allowed to sniff your traffic."
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
