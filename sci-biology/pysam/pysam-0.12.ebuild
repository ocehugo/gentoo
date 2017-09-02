# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Python interface for the SAM/BAM sequence alignment and mapping format"
HOMEPAGE="
	https://github.com/pysam-developers/pysam
	https://pypi.python.org/pypi/pysam"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="=sci-libs/htslib-1.5*:="
DEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	export HTSLIB_INCLUDE_DIR="${EPREFIX}"/usr/include
	export HTSLIB_LIBRARY_DIR="${EPREFIX}"/usr/$(get_libdir)
	export HTSLIB_CONFIGURE_OPTIONS="--disable-libcurl"

	# prevent setup.py from adding RPATHs
	sed -e "/ext\.extra_link_args += \['-Wl,-rpath,\$ORIGIN'\]/d" \
		-i cy_build.py || die
	sed -e '/runtime_library_dirs=htslib_library_dirs/d' \
		-i setup.py || die

	distutils-r1_python_prepare_all
}

src_compile() {
	# TODO
	# empty compile, as the build system runs the whole build again in install
	:
}
