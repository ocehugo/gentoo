# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit desktop

DESCRIPTION="Puzzle game like the known tetromino and the average pipe games"
HOMEPAGE="http://tamentis.com/projects/rezerwar/"
SRC_URI="http://tamentis.com/projects/rezerwar/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl[sound,joystick,video]
	media-libs/sdl-mixer[vorbis]"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i \
		-e '/check_sdl$/d' \
		-e 's/-O2 //' \
		configure \
		|| die 'sed failed'
	sed -i \
		-e '/CC.*OBJECTS/s:$(CC):$(CC) $(LDFLAGS):' \
		mkfiles/Makefile.src \
		|| die "sed failed"
}

src_configure() {
	SDLCONFIG=sdl-config \
	TARGET_BIN="/usr/bin" \
	TARGET_DOC=/usr/share/doc/${PF} \
	TARGET_DATA="/usr/share/${PN}" \
		./configure || die "configure failed"
	sed -i \
		-e '/TARGET_DOC/d' \
		Makefile \
		|| die "sed failed"
}

src_install() {
	dodir /usr/bin
	default
	dodoc doc/{CHANGES,README,TODO}
	make_desktop_entry rezerwar Rezerwar
}
