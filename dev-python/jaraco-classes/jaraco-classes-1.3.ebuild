# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

MY_PN="${PN/-/.}"
DESCRIPTION="Classes used by other projects by developer jaraco"
HOMEPAGE="https://github.com/jaraco/jaraco.classes"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/hgtools[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_PN}-${PV}"

python_prepare_all() {
	if use test && has_version "${CATEGORY}/${PN}"; then
		die "Ensure $PN is not already installed or the test suite will fail"
	fi
	distutils-r1_python_prepare_all
}

python_test() {
	PYTHONPATH=. py.test || die "tests failed with ${EPYTHON}"
}
