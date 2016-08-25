# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby20 ruby21 ruby22 ruby23"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Provides a mailcap-like MIME Content-Type lookup for Ruby"
HOMEPAGE="https://github.com/mime-types/ruby-mime-types"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64 ~arm"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/minitest:5 dev-ruby/minitest-bonus-assertions:2 dev-ruby/minitest-hooks:1 )"

ruby_add_rdepend ">=dev-ruby/mime-types-data-3.2015:3"

all_ruby_prepare() {
	# Avoid unneeded developer-only dependencies.
	sed -i -e '/\(focus\|rg\)/ s:^:#:' \
		-e 's:fivemat/::' test/minitest_helper.rb || die
}

each_ruby_test() {
	${RUBY} -Ilib:test:. -e 'Dir["test/test_*.rb"].each{|f| require f}' || die
}
