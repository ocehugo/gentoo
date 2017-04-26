# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit bash-completion-r1 eutils toolchain-funcs

MY_PV="${PV/_p/_r}"
MY_P=${PN}-${MY_PV}

DESCRIPTION="Android platform tools (adb, fastboot, and mkbootimg)"
HOMEPAGE="https://android.googlesource.com/platform/system/core.git/"
# Downloading git tarballs generated by android.googlesource.com
# Archlinux package contains patches and build script generation mechanism.
SRC_URI="https://git.archlinux.org/svntogit/community.git/snapshot/community-6a03c4736c9734f5ac3d6b5b912605690a6eaa5f.tar.gz -> ${MY_P}-arch.tar.gz
https://github.com/android/platform_system_core/archive/android-${MY_PV}.tar.gz -> ${MY_P}-core.tar.gz
mirror://gentoo/${MY_P}-extras.tar.gz
mirror://gentoo/${MY_P}-libselinux.tar.gz
mirror://gentoo/${MY_P}-f2fs-tools.tar.gz"

# The entire source code is Apache-2.0, except for fastboot which is BSD-2.
LICENSE="Apache-2.0 BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm-linux ~x86-linux"
IUSE="libressl"

RDEPEND="sys-libs/zlib:=
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	dev-libs/libpcre"
# dev-lang/ruby is necessary for build script generation.
DEPEND="${RDEPEND}
	dev-lang/ruby:*"

S=${WORKDIR}

src_unpack() {
	local dir filename
	for filename in ${A}; do
		if [[ ${filename} =~ ^${MY_P}-(.*)\.tar\.gz$ ]]; then
			dir=${BASH_REMATCH[1]}
			mkdir -p "${dir}" || die
			pushd "${dir}" >/dev/null
			unpack "${filename}"
			popd > /dev/null
		else
			die "unrecognized file in \${A}: ${filename}"
		fi
	done
}

src_prepare() {
	mv core/*/* core/ || die
	epatch arch/*/trunk/fix_build.patch
	cp arch/*/trunk/generate_build.rb ./ || die
	sed -i '1i#include <sys/sysmacros.h>' core/adb/usb_linux.cpp || die #616508
	sed -e 's|^#include <sys/cdefs.h>$|/*\0*/|' \
		-e 's|^__BEGIN_DECLS$|#ifdef __cplusplus\nextern "C" {\n#endif|' \
		-e 's|^__END_DECLS$|#ifdef __cplusplus\n}\n#endif|' \
		-i extras/ext4_utils/sha1.{c,h} || die #580686
	default
}

src_compile() {
	chmod +x ./generate_build.rb || die
	./generate_build.rb > build.sh || die
	chmod +x build.sh || die
	bash -e ./build.sh || die
}

src_install() {
	dobin adb
	dobin fastboot
	dobin mkbootimg
	# Omitting, app-shells/bash-completion contains completion for adb
	#newbashcomp arch/*/trunk/bash_completion.adb adb
	newbashcomp arch/*/trunk/bash_completion.fastboot fastboot
}
