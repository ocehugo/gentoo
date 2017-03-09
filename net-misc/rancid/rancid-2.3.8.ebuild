# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools eutils readme.gentoo user

DESCRIPTION="Really Awesome New Cisco confIg Differ"
HOMEPAGE="http://www.shrubbery.net/rancid/"
SRC_URI="http://http.debian.net/debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.orig.tar.gz -> ${P}.tar.gz"
LICENSE="BSD-4"

SLOT="0"
RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"
IUSE="+cvs subversion"

REQUIRED_USE="^^ ( cvs subversion )"

# app-arch/par is blocker, due to bug #455838
DEPEND="
	!app-arch/par
	dev-lang/perl
	dev-lang/tcl:0=
	dev-tcltk/expect
	sys-apps/diffutils
	cvs? ( dev-vcs/cvs )
	subversion? ( dev-vcs/subversion )
	|| (
		net-misc/netkit-telnetd
		net-misc/telnet-bsd
	)"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-mailprefix.patch
	epatch "${FILESDIR}"/${P}-config.patch
	epatch "${FILESDIR}"/${P}-buildsystem.patch

	# respect CFLAGS, bug #455840
	sed -i -e '/^CFLAGS/d' bin/Makefile.am || die 'sed on bin/Makefile.am failed'

	eautoreconf
}

src_configure() {
	econf \
		--localstatedir="${EPREFIX}"/var/${PN} \
		--enable-conf-install \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html \
		$(use subversion && echo "--with-svn=fsfs")
}

src_install() {
	default

	if use subversion ; then
		sed -e 's/^RCSSYS=cvs/RCSSYS=svn/' \
			-i "${D}"/etc/rancid.conf || die
	fi

	echo "CONFIG_PROTECT=\"${EPREFIX}/var/rancid/.cloginrc\"" > "${T}"/99${PN}
	doenvd "${T}"/99${PN}

	readme.gentoo_src_install
}

pkg_preinst() {
	enewgroup ${PN}
	enewuser ${PN} -1 /bin/bash "${EPREFIX}"/var/rancid ${PN}

	keepdir /var/${PN}{,/logs}
	touch 	"${ED}"/var/${PN}/.cloginrc

	fperms ug=rwX,o= /var/${PN}/{,logs,.cloginrc}
	fowners ${PN}:${PN} /var/${PN}/{,logs,.cloginrc}
}

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="Micro-HOWTO on how to get running:

1) Modify MAILPREFIX, ADMINMAILPREFIX, and LIST_OF_GROUPS
in /etc/rancid.conf:
MAILPREFIX=\"rancid-\"
ADMINMAILPREFIX=\"rancid-admin-\"
LIST_OF_GROUPS=\"routers switches\"

2) Setup email aliases for rancid:
you will need to define mail aliases for {MAILPREFIX}{GROUP}
and {ADMINMAILPREFIX}{GROUP} for each group you defined above
How to do this depends on your mailserver

3) Run rancid-cvs as the rancid user to initialise directories and
repositories; eg. su -c /usr/bin/rancid-cvs - rancid
Note the command is the same even if you are using subversion

4) Populate /var/rancid/{GROUPNAME}/router.db with nodes
see man 5 router.db for detailed formatting information

5) Populate /var/rancid/.cloginrc with credentials
see /usr/share/rancid/cloginrc.sample for an example

6) Test clogin access with: clogin -f /var/rancid/.clogin hostname

7) Add a cronjob for the rancid user to regularly call rancid-run
eg: run crontab -u rancid -e and add the lines below
# run rancid once an hour
0 * * * *	/usr/bin/rancid-run
# cleanup old logfiles generated by rancid once a day
50 23 * * *	/usr/bin/find /var/rancid/logs -type f -mtime +2 -exec rm {} \;
"
