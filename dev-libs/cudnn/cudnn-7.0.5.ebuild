# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CUDA_PV=9.0

inherit versionator

DESCRIPTION="NVIDIA Accelerated Deep Learning on GPU library"
HOMEPAGE="https://developer.nvidia.com/cuDNN"

MY_PV_MAJOR=$(get_major_version)
SRC_URI="cudnn-${CUDA_PV}-linux-x64-v${MY_PV_MAJOR}.tgz"

SLOT="0/7"
KEYWORDS="~amd64 ~amd64-linux"
RESTRICT="fetch"
LICENSE="NVIDIA-cuDNN"

S="${WORKDIR}"

DEPENDS="=dev-util/nvidia-cuda-toolkit-${CUDA_PV}*"
RDEPENDS="${DEPENDS}"

src_install() {
	insinto /opt
	doins -r *
}
