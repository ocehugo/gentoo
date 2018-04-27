# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{3_4,3_5,3_6} )
inherit distutils-r1 multilib

DESCRIPTION="Release metatool used for creating releases based on Gentoo Linux"
HOMEPAGE="https://wiki.gentoo.org/wiki/Catalyst"
if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://anongit.gentoo.org/git/proj/catalyst.git"
	inherit git-r3
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2
		https://dev.gentoo.org/~dolsen/releases/catalyst/${P}.tar.bz2
		https://dev.gentoo.org/~jmbsvicetto/distfiles/${P}.tar.bz2
		https://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.bz2"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="ccache doc kernel_linux"

DEPEND="
	app-text/asciidoc
	>=dev-python/snakeoil-0.6.5[${PYTHON_USEDEP}]
"
RDEPEND="
	=dev-python/pydecomp-9999[${PYTHON_USEDEP}]
	app-arch/lbzip2
	app-crypt/shash
	sys-fs/dosfstools
	!kernel_FreeBSD? ( || ( app-arch/tar[xattr] app-arch/libarchive[xattr] ) )
	kernel_FreeBSD? ( app-arch/libarchive[xattr] )
	virtual/cdrtools
	amd64? ( >=sys-boot/syslinux-3.72 )
	x86? ( >=sys-boot/syslinux-3.72 )
	ccache? ( dev-util/ccache )
	kernel_linux? ( app-misc/zisofs-tools >=sys-fs/squashfs-tools-2.1 )
"

python_prepare_all() {
	python_setup
	echo VERSION="${PV}" "${PYTHON}" setup.py set_version
	VERSION="${PV}" "${PYTHON}" setup.py set_version || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	# build the man pages and docs
	emake
}

python_install_all() {
	distutils-r1_python_install_all
	if use doc; then
		dodoc files/HOWTO.html files/docbook-xsl.css
	fi
}
