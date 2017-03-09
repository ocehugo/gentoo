# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KEYWORDS="~amd64"
EGO_PN="github.com/odeke-em/drive/..."
EGIT_COMMIT="v${PV}"
SRC_URI="https://${EGO_PN%/*}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
https://github.com/GoogleCloudPlatform/gcloud-golang/archive/a5e721bf760c8055ea3ae8b732da1dc6a10fc3f9.tar.gz -> gcloud-golang-a5e721bf760c8055ea3ae8b732da1dc6a10fc3f9.tar.gz
https://github.com/boltdb/bolt/archive/a705895fdad108f053eae7ee011ed94a0541ee13.tar.gz -> bolt-a705895fdad108f053eae7ee011ed94a0541ee13.tar.gz
https://github.com/cheggaaa/pb/archive/d7e6ca3010b6f084d8056847f55d7f572f180678.tar.gz -> pb-d7e6ca3010b6f084d8056847f55d7f572f180678.tar.gz
https://github.com/codegangsta/inject/archive/33e0aa1cb7c019ccc3fbe049a8262a6403d30504.tar.gz -> inject-33e0aa1cb7c019ccc3fbe049a8262a6403d30504.tar.gz
https://github.com/go-martini/martini/archive/fe605b5cd210047ae3bb73d2b69a5b912a9b423d.tar.gz -> martini-fe605b5cd210047ae3bb73d2b69a5b912a9b423d.tar.gz
https://github.com/golang/crypto/archive/91902e332b9d47760598861512d2ae148f94ca58.tar.gz -> crypto-91902e332b9d47760598861512d2ae148f94ca58.tar.gz
https://github.com/golang/net/archive/f2499483f923065a842d38eb4c7f1927e6fc6e6d.tar.gz -> net-f2499483f923065a842d38eb4c7f1927e6fc6e6d.tar.gz
https://github.com/golang/oauth2/archive/314dd2c0bf3ebd592ec0d20847d27e79d0dbe8dd.tar.gz -> oauth2-314dd2c0bf3ebd592ec0d20847d27e79d0dbe8dd.tar.gz
https://github.com/golang/protobuf/archive/8ee79997227bf9b34611aee7946ae64735e6fd93.tar.gz -> golang-protobuf-8ee79997227bf9b34611aee7946ae64735e6fd93.tar.gz
https://github.com/google/google-api-go-client/archive/8840436417f044055c16fc7e4018f08484f52839.tar.gz -> google-api-go-client-8840436417f044055c16fc7e4018f08484f52839.tar.gz
https://github.com/googleapis/gax-go/archive/da06d194a00e19ce00d9011a13931c3f6f6887c7.tar.gz -> gax-go-da06d194a00e19ce00d9011a13931c3f6f6887c7.tar.gz
https://github.com/grpc/grpc-go/archive/50955793b0183f9de69bd78e2ec251cf20aab121.tar.gz -> grpc-go-50955793b0183f9de69bd78e2ec251cf20aab121.tar.gz
https://github.com/martini-contrib/binding/archive/05d3e151b6cf34dacac6306226a33db68459a3b5.tar.gz -> binding-05d3e151b6cf34dacac6306226a33db68459a3b5.tar.gz
https://github.com/mattn/go-isatty/archive/30a891c33c7cde7b02a981314b4228ec99380cca.tar.gz -> go-isatty-30a891c33c7cde7b02a981314b4228ec99380cca.tar.gz
https://github.com/mattn/go-runewidth/archive/737072b4e32b7a5018b4a7125da8d12de90e8045.tar.gz -> go-runewidth-737072b4e32b7a5018b4a7125da8d12de90e8045.tar.gz
https://github.com/odeke-em/cache/archive/baf8e436bc97557118cb0bf118ab8ac6aeeda381.tar.gz -> cache-baf8e436bc97557118cb0bf118ab8ac6aeeda381.tar.gz
https://github.com/odeke-em/cli-spinner/archive/610063bb4aeef25f7645b3e6080456655ec0fb33.tar.gz -> cli-spinner-610063bb4aeef25f7645b3e6080456655ec0fb33.tar.gz
https://github.com/odeke-em/command/archive/91ca5ec5e9a1bc2668b1ccbe0967e04a349e3561.tar.gz -> command-91ca5ec5e9a1bc2668b1ccbe0967e04a349e3561.tar.gz
https://github.com/odeke-em/exponential-backoff/archive/96e25d36ae36ad09ac02cbfe653b44c4043a8e09.tar.gz -> exponential-backoff-96e25d36ae36ad09ac02cbfe653b44c4043a8e09.tar.gz
https://github.com/odeke-em/extractor/archive/801861aedb854c7ac5e1329e9713023e9dc2b4d4.tar.gz -> extractor-801861aedb854c7ac5e1329e9713023e9dc2b4d4.tar.gz
https://github.com/odeke-em/go-utils/archive/d915395a7a46a9fe73d93f4daeff5953eeac5ef2.tar.gz -> go-utils-d915395a7a46a9fe73d93f4daeff5953eeac5ef2.tar.gz
https://github.com/odeke-em/go-uuid/archive/b211d769a9aaba5b2b8bdbab5de3c227116f3c39.tar.gz -> go-uuid-b211d769a9aaba5b2b8bdbab5de3c227116f3c39.tar.gz
https://github.com/odeke-em/log/archive/8d60a6917853243fd746612e6ba47843a794fa82.tar.gz -> log-8d60a6917853243fd746612e6ba47843a794fa82.tar.gz
https://github.com/odeke-em/meddler/archive/d2b51d2b40e786ab5f810d85e65b96404cf33570.tar.gz -> meddler-d2b51d2b40e786ab5f810d85e65b96404cf33570.tar.gz
https://github.com/odeke-em/namespace/archive/0ab79ba44f1328b1ec75ea985ad5c338ba3d56a6.tar.gz -> namespace-0ab79ba44f1328b1ec75ea985ad5c338ba3d56a6.tar.gz
https://github.com/odeke-em/pretty-words/archive/9d37a7fcb4ae6f94b288d371938482994458cecb.tar.gz -> pretty-words-9d37a7fcb4ae6f94b288d371938482994458cecb.tar.gz
https://github.com/odeke-em/ripper/archive/bd1a682568fcb8a480b977bb5851452fc04f9ccb.tar.gz -> ripper-bd1a682568fcb8a480b977bb5851452fc04f9ccb.tar.gz
https://github.com/odeke-em/rsc/archive/6ad75e1e26192f3d140b6486deb99c9dbd289846.tar.gz -> rsc-6ad75e1e26192f3d140b6486deb99c9dbd289846.tar.gz
https://github.com/odeke-em/semalim/archive/9c88bf5f9156ed06ec5110a705d41b8580fd96f7.tar.gz -> semalim-9c88bf5f9156ed06ec5110a705d41b8580fd96f7.tar.gz
https://github.com/odeke-em/statos/archive/292960a201e2310a667eac7796f4e11cd51021a3.tar.gz -> statos-292960a201e2310a667eac7796f4e11cd51021a3.tar.gz
https://github.com/skratchdot/open-golang/archive/75fb7ed4208cf72d323d7d02fd1a5964a7a9073c.tar.gz -> open-golang-75fb7ed4208cf72d323d7d02fd1a5964a7a9073c.tar.gz"
DESCRIPTION="Google Drive client for the commandline"
HOMEPAGE="https://${EGO_PN%/*}"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
DEPEND="dev-lang/go:="

get_archive_go_package() {
	local archive=${1} uri x
	case ${archive} in
		oauth2-*) echo "oauth2-* golang.org/x/oauth2"; return;;
		google-api-go-client-*) echo "google-api-go-client-* google.golang.org/api"; return;;
		gcloud-golang-*) echo "google-cloud-go-* cloud.google.com/go"; return;;
		grpc-go-*) echo "grpc-go-* google.golang.org/grpc"; return;;
		net-*) echo "net-* golang.org/x/net"; return;;
		crypto-*) echo "crypto-* golang.org/x/crypto"; return;;
	esac
	for x in ${SRC_URI}; do
		if [[ ${x} == http* ]]; then
			uri=${x}
		elif [[ ${x} == ${archive} ]]; then
			break
		fi
	done
	uri=${uri#https://}
	uri=${uri%/archive/*}
	echo "${uri##*/}-* ${uri}"
}

unpack_go_packages() {
	local go_package pattern x
	# Unpack packages to appropriate locations for GOPATH
	for x in ${A}; do
		unpack ${x}
		if [[ ${x} == *.tar.gz ]]; then
			go_package=$(get_archive_go_package ${x})
			pattern=${go_package%% *}
			go_package=${go_package##* }
			if [[ ${x%.tar.gz} -ef ${S} ]]; then
				mv "${S}"{,_} || die
				mkdir -p "${S}/src/${go_package%/*}" || die
				mv "${S}"_ "${S}/src/${go_package}" || die || die
			else
				mkdir -p "${S}/src/${go_package%/*}" || die
				for x in ${pattern}; do
					if [[ ! ${x} -ef ${S} ]]; then
						mv "${x}" "${S}/src/${go_package}" || die
					fi
				done
			fi
		fi
	done
}

src_unpack() {
	unpack_go_packages
}

src_prepare() {
	default
	rm -rf "${S}/src/${EGO_PN%/*}/drive-gen/Godeps/_workspace" || die
}

src_compile() {
	GOPATH="${WORKDIR}/${P}" \
		go install -v -work -x ${EGO_BUILD_FLAGS} "${EGO_PN}" || die
}

src_install() {
	dodoc "${S}/src/${EGO_PN%/*}/README.md"
	dobin "${S}/bin/drive"{,-server}
}
