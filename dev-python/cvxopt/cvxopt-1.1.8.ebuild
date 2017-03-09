# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1 eutils toolchain-funcs

DESCRIPTION="Python package for convex optimization"
HOMEPAGE="http://cvxopt.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc +dsdp examples fftw +glpk gsl"

RDEPEND="
	virtual/blas
	virtual/cblas
	virtual/lapack
	sci-libs/amd:0=
	sci-libs/cholmod:0=
	sci-libs/colamd:0=
	sci-libs/suitesparseconfig:0=
	sci-libs/umfpack:0=
	dsdp? ( sci-libs/dsdp:0= )
	fftw? ( sci-libs/fftw:3.0= )
	glpk? ( >=sci-mathematics/glpk-4.49:0= )
	gsl? ( sci-libs/gsl:0= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( dev-python/sphinx )"

python_prepare_all(){
	epatch "${FILESDIR}"/${P}-setup.patch

	rm -r src/C/SuiteSparse*/ || die

	pkg_lib() {
		local pkg=$(echo $1 | tr '[:lower:]' '[:upper:]')
		local libs="$($(tc-getPKG_CONFIG) --libs-only-l $1 | \
			sed -e 's:[ ]-l*\(pthread\|m\)\([ ]\|$\)::g' -e 's:[ ]*$::' | \
			tr ' ' '\n' | sort -u | sed -e "s:^-l\(.*\):'\1':g" | \
			tr '\n' ',' | sed -e 's:,$::')"
		local libdir="$($(tc-getPKG_CONFIG) --libs-only-L $1 | \
			sed -e 's:[ ]*$::' | \
			tr ' ' '\n' | sort -u | sed -e "s:^-L\(.*\):'\1':g" | \
			tr '\n' ',' | sed -e 's:,$::')"
		local incdir="$($(tc-getPKG_CONFIG) --cflags-only-I $1 | \
			sed -e 's:[ ]*$::' | \
			tr ' ' '\n' | sort -u | sed -e "s:^-L\(.*\):'\1':g" | \
			tr '\n' ',' | sed -e 's:,$::')"
		sed -i \
			-e "/${pkg}_LIB[ ]*=/s:\(.*[ ]*=[ ]*\[\).*${1}.*:\1${libs}\]:" \
			-e "s:\(${pkg}_INC_DIR[ ]*=\).*$:\1 ${incdir}:" \
			-e "s:\[ BLAS_LIB_DIR \]:\[ ${libdir} \]:g" \
			setup.py || die
	}

	use_cvx() {
		local flag=$1
		if use ${flag} ; then
			# Switch to ^^ when we switch to EAPI=6.
			#local uflag=${flag^^}
			local uflag=$(tr '[:lower:]' '[:upper:]' <<<"${flag}")
			sed -i \
				-e "s/\(BUILD_${uflag} =\) 0/\1 1/" \
				setup.py || die
		fi
	}

	pkg_lib blas
	pkg_lib lapack

	use_cvx gsl
	use_cvx fftw
	use_cvx glpk
	use_cvx dsdp

	sed \
		-e '/SUITESPARSE_EXT_LIB/s:0:1:g' \
		-i setup.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && export VARTEXFONTS="${T}/fonts" && emake -C doc -B html
}

python_test() {
	cd examples/doc/chap8
	"${EPYTHON}" lp.py || die
}

python_install_all() {
	use doc && HTML_DOCS=( doc/build/html/. )
	insinto /usr/share/doc/${PF}
	use examples && EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
