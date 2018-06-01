# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="a set of tools for updating gentoo config files"
HOMEPAGE="https://sourceforge.net/projects/etc-proposals.berlios/"
SRC_URI="mirror://sourceforge/${PN}.berlios/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"

DEPEND=">=dev-python/pygtk-2.10"
RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all

	dodir /usr/sbin
	einfo "Moving /usr/bin/etc-proposals to /usr/sbin/etc-proposals"
	mv "${ED%/}/usr/bin/etc-proposals" "${ED%/}/usr/sbin/etc-proposals" || die
	rmdir "${ED%/}/usr/bin" || die

	# Package has PyQt4 support no one ported to PyQt5 so far, bug #634956
	sed -i -e '/^PreferedFrontends=/ s/qt4,//' "${D}"/etc/etc-proposals.conf
}

pkg_postinst() {
	elog "The configuration file has been installed to /etc/etc-proposals.conf"
	elog "If you are installing etc-proposals for the first time or updating"
	elog "from a version < 1.3 you should run the following command once:"
	elog "etc-proposals --init-db"
	ewarn "A full backup of /etc and other files managed by CONFIG_PROTECT"
	ewarn "is highly advised before testing this tool!"
}
