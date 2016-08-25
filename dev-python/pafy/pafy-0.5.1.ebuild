# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )
inherit distutils-r1

DESCRIPTION="Python library to retrieve YouTube content and metadata"
HOMEPAGE="http://np1.github.io/pafy/ https://pypi.python.org/pypi/pafy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="net-misc/youtube-dl[${PYTHON_USEDEP}]"
