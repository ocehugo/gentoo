# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=(python{2_7,3_4} pypy)
PYTHON_REQ_USE="xml(+),threads(+)"

inherit distutils-r1 eutils

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Portage-Tools"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

DEPEND="sys-apps/portage[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	!<=app-portage/gentoolkit-dev-0.2.7
	sys-apps/gawk
	sys-apps/gentoo-functions"

PATCHES=(
	"${FILESDIR}"/${PV}-revdep-rebuild-py-504654-1.patch
	"${FILESDIR}"/${PV}-revdep-rebuild-py-504654-2.patch
	"${FILESDIR}"/${PV}-equery-508114.patch
	"${FILESDIR}"/${PV}-equery-strip-XXXFLAGS.patch
	"${FILESDIR}"/${PV}-revdep-rebuild-526400.patch
)

python_prepare_all() {
	epatch "${FILESDIR}/0.3.1-setup.py-print.patch"
	python_setup
	echo VERSION="${PVR}" "${PYTHON}" setup.py set_version
	VERSION="${PVR}" "${PYTHON}" setup.py set_version
	mv ./bin/revdep-rebuild{,.py} || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	# Rename the python versions of revdep-rebuild, since we are not ready
	# to switch to the python version yet. Link /usr/bin/revdep-rebuild to
	# revdep-rebuild.sh. Leaving the python version available for potential
	# testing by a wider audience.
	dosym revdep-rebuild.sh /usr/bin/revdep-rebuild

	# TODO: Fix this as it is now a QA violation
	# Create cache directory for revdep-rebuild
	keepdir /var/cache/revdep-rebuild
	use prefix || fowners root:0 /var/cache/revdep-rebuild
	fperms 0700 /var/cache/revdep-rebuild

	# remove on Gentoo Prefix platforms where it's broken anyway
	if use prefix; then
		elog "The revdep-rebuild command is removed, the preserve-libs"
		elog "feature of portage will handle issues."
		rm "${ED}"/usr/bin/revdep-rebuild*
		rm "${ED}"/usr/share/man/man1/revdep-rebuild.1
		rm -rf "${ED}"/etc/revdep-rebuild
		rm -rf "${ED}"/var
	fi
}

pkg_postinst() {
	# Only show the elog information on a new install
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		elog
		elog "For further information on gentoolkit, please read the gentoolkit"
		elog "guide: https://wiki.gentoo.org/wiki/Gentoolkit"
		elog
		elog "Another alternative to equery is app-portage/portage-utils"
		elog
		elog "Additional tools that may be of interest:"
		elog
		elog "    app-admin/eclean-kernel"
		elog "    app-portage/diffmask"
		elog "    app-portage/flaggie"
		elog "    app-portage/install-mask"
		elog "    app-portage/portpeek"
		elog "    app-portage/smart-live-rebuild"
	fi
}
