# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit webapp

MY_PV=${PV:0:3}.0

DESCRIPTION="PHP-based open-source platform and content management system"
HOMEPAGE="https://www.drupal.org/"
SRC_URI="https://ftp.drupal.org/files/projects/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="+accelerator +mysql postgres sqlite +uploadprogress"

RDEPEND="
	dev-lang/php[gd,hash,pdo,postgres?,simplexml,xml]
	virtual/httpd-php
	accelerator? ( ||
		(
			dev-php/xcache
			(
				>=dev-lang/php-5.5[opcache]
				dev-php/pecl-apcu
			)
		)
	)
	uploadprogress? ( dev-php/pecl-uploadprogress )
	mysql? (
		|| (
			dev-lang/php[mysql]
			dev-lang/php[mysqli]
		)
	)
	sqlite? ( dev-lang/php[sqlite] )
"

need_httpd_cgi

REQUIRED_USE="|| ( mysql postgres sqlite )"

src_install() {
	webapp_src_preinst

	local docs="MAINTAINERS.txt LICENSE.txt INSTALL.txt CHANGELOG.txt INSTALL.mysql.txt INSTALL.pgsql.txt INSTALL.sqlite.txt UPGRADE.txt "
	dodoc ${docs}
	rm -f ${docs} INSTALL COPYRIGHT.txt || die

	cp sites/default/{default.settings.php,settings.php} || die
	insinto "${MY_HTDOCSDIR}"
	doins -r .

	dodir "${MY_HTDOCSDIR}"/files
	webapp_serverowned "${MY_HTDOCSDIR}"/files
	webapp_serverowned "${MY_HTDOCSDIR}"/sites/default
	webapp_serverowned "${MY_HTDOCSDIR}"/sites/default/settings.php

	webapp_configfile "${MY_HTDOCSDIR}"/sites/default/settings.php
	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}

pkg_postinst() {
	echo
	ewarn "SECURITY NOTICE"
	ewarn "If you plan on using SSL on your Drupal site, please consult the postinstall information:"
	ewarn "\t# webapp-config --show-postinst ${PN} ${PV}"
	echo
}
