# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit qt5-build

DESCRIPTION="Hardware sensor access library for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~x86"
fi

# TODO: simulator
IUSE="examples qml"

RDEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtdbus-${PV}
	qml? ( ~dev-qt/qtdeclarative-${PV} )
	examples? ( ~dev-qt/qtwidgets-${PV} )
"
DEPEND="${RDEPEND}"

QT5_EXAMPLES_SUBDIRS=(
	examples
)

src_prepare() {
	qt_use_disable_mod qml quick \
		src/src.pro \
		examples/sensors/sensors.pro

	qt5-build_src_prepare
}
