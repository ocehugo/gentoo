# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: virtualx.eclass
# @MAINTAINER:
# x11@gentoo.org
# @AUTHOR:
# Original author: Martin Schlemmer <azarah@gentoo.org>
# @BLURB: This eclass can be used for packages that needs a working X environment to build.

case "${EAPI:-0}" in
	0|1)
		die "virtualx eclass require EAPI=2 or newer."
		;;
	2|3|4|5|6)
		;;
	*)
		die "EAPI ${EAPI} is not supported yet."
		;;
esac

if [[ ! ${_VIRTUAL_X} ]]; then

inherit eutils

# @ECLASS-VARIABLE: VIRTUALX_REQUIRED
# @DESCRIPTION:
# Variable specifying the dependency on xorg-server and xhost.
# Possible special values are "always" and "manual", which specify
# the dependency to be set unconditionaly or not at all.
# Any other value is taken as useflag desired to be in control of
# the dependency (eg. VIRTUALX_REQUIRED="kde" will add the dependency
# into "kde? ( )" and add kde into IUSE.
: ${VIRTUALX_REQUIRED:=test}

# @ECLASS-VARIABLE: VIRTUALX_DEPEND
# @DESCRIPTION:
# Dep string available for use outside of eclass, in case a more
# complicated dep is needed.
# You can specify the variable BEFORE inherit to add more dependencies.
VIRTUALX_DEPEND="${VIRTUALX_DEPEND}
	!prefix? ( x11-base/xorg-server[xvfb] )
	x11-apps/xhost
"

# @ECLASS-VARIABLE: VIRTUALX_COMMAND
# @DESCRIPTION:
# Command (or eclass function call) to be run in the X11 environment
# (within virtualmake function).
: ${VIRTUALX_COMMAND:="emake"}

case ${VIRTUALX_REQUIRED} in
	manual)
		;;
	always)
		DEPEND="${VIRTUALX_DEPEND}"
		RDEPEND=""
		;;
	optional|tests)
		[[ ${EAPI} == [2345] ]] || die 'Values "optional" and "tests" are unsupported for VIRTUALX_REQUIRED'
		# deprecated section YAY.
		eqawarn "VIRTUALX_REQUIRED=optional and VIRTUALX_REQUIRED=tests are deprecated."
		eqawarn "You can drop the variable definition completely from ebuild,"
		eqawarn "because it is default behaviour."

		if [[ -n ${VIRTUALX_USE} ]]; then
			# so they like to specify the useflag
			eqawarn "VIRTUALX_USE variable is deprecated."
			eqawarn "Please read eclass manpage to find out how to use VIRTUALX_REQUIRED"
			eqawarn "to achieve the same behaviour."
		fi

		[[ -z ${VIRTUALX_USE} ]] && VIRTUALX_USE="test"
		DEPEND="${VIRTUALX_USE}? ( ${VIRTUALX_DEPEND} )"
		RDEPEND=""
		IUSE="${VIRTUALX_USE}"
		;;
	*)
		DEPEND="${VIRTUALX_REQUIRED}? ( ${VIRTUALX_DEPEND} )"
		RDEPEND=""
		IUSE="${VIRTUALX_REQUIRED}"
		;;
esac

# @FUNCTION: virtualmake
# @DESCRIPTION:
# Function which start new Xvfb session
# where the VIRTUALX_COMMAND variable content gets executed.
virtualmake() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${EAPI} == [2345] ]] || die "${FUNCNAME} is unsupported in EAPI > 5, please use virtx"

	# backcompat for maketype
	if [[ -n ${maketype} ]]; then
		[[ ${EAPI} == [2345] ]] || die "maketype is banned in EAPI > 5"
		eqawarn "ebuild is exporting \$maketype=${maketype}"
		eqawarn "Ebuild should be migrated to use VIRTUALX_COMMAND=${maketype} instead."
		eqawarn "Setting VIRTUALX_COMMAND to \$maketype conveniently for now."
		VIRTUALX_COMMAND=${maketype}
	fi

	virtx "${VIRTUALX_COMMAND}" "${@}"
}


# @FUNCTION: virtualmake
# @USAGE: <command> [comman arguments]
# @DESCRIPTION:
# Function which start new Xvfb session where the command gets executed.
virtx() {
	debug-print-function ${FUNCNAME} "$@"

	[[ $# -lt 1 ]] && die "${FUNCNAME} needs at least one argument"

	local i=0
	local retval=0
	local OLD_SANDBOX_ON="${SANDBOX_ON}"
	local XVFB XHOST XDISPLAY
	local xvfbargs="-screen 0 1280x1024x24"
	XVFB=$(type -p Xvfb) || die
	XHOST=$(type -p xhost) || die

	debug-print "${FUNCNAME}: running Xvfb hack"
	export XAUTHORITY=
	# The following is derived from Mandrake's hack to allow
	# compiling without the X display

	einfo "Scanning for an open DISPLAY to start Xvfb ..."
	# If we are in a chrooted environment, and there is already a
	# X server started outside of the chroot, Xvfb will fail to start
	# on the same display (most cases this is :0 ), so make sure
	# Xvfb is started, else bump the display number
	#
	# Azarah - 5 May 2002
	XDISPLAY=$(i=0; while [[ -f /tmp/.X${i}-lock ]] ; do ((i++));done; echo ${i})
	debug-print "${FUNCNAME}: XDISPLAY=${XDISPLAY}"

	# We really do not want SANDBOX enabled here
	export SANDBOX_ON="0"

	debug-print "${FUNCNAME}: ${XVFB} :${XDISPLAY} ${xvfbargs}"
	${XVFB} :${XDISPLAY} ${xvfbargs} &>/dev/null &
	sleep 2

	local start=${XDISPLAY}
	while [[ ! -f /tmp/.X${XDISPLAY}-lock ]]; do
		# Stop trying after 15 tries
		if ((XDISPLAY - start > 15)) ; then
			eerror "'${XVFB} :${XDISPLAY} ${xvfbargs}' returns:"
			echo
			${XVFB} :${XDISPLAY} ${xvfbargs}
			echo
			eerror "If possible, correct the above error and try your emerge again."
			die "Unable to start Xvfb"
		fi
			((XDISPLAY++))
		debug-print "${FUNCNAME}: ${XVFB} :${XDISPLAY} ${xvfbargs}"
		${XVFB} :${XDISPLAY} ${xvfbargs} &>/dev/null &
		sleep 2
	done

	# Now enable SANDBOX again if needed.
	export SANDBOX_ON="${OLD_SANDBOX_ON}"

	einfo "Starting Xvfb on \$DISPLAY=${XDISPLAY} ..."

	export DISPLAY=:${XDISPLAY}
	# Do not break on error, but setup $retval, as we need
	# to kill Xvfb
	debug-print "${FUNCNAME}: ${VIRTUALX_COMMAND} \"$@\""
	if has "${EAPI}" 2 3; then
		"$@"
		retval=$?
	else
		nonfatal "$@"
		retval=$?
	fi

	# Now kill Xvfb
	kill $(cat /tmp/.X${XDISPLAY}-lock)

	# die if our command failed
	[[ ${retval} -ne 0 ]] && die "${FUNCNAME}: the ${VIRTUALX_COMMAND} failed."

	return 0 # always return 0, it can be altered by failed kill for Xvfb
}

# @FUNCTION: Xmake
# @DESCRIPTION:
# Same as "make", but set up the Xvfb hack if needed.
# Deprecated call.
Xmake() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${EAPI} == [2345] ]] \
		|| die "${FUNCNAME} is unsupported in EAPI > 5, please use 'virtx emake -j1 ....'"

	eqawarn "you should not execute make directly"
	eqawarn "rather execute Xemake -j1 if you have issues with parallel make"
	VIRTUALX_COMMAND="emake -j1" virtualmake "$@"
}

# @FUNCTION: Xemake
# @DESCRIPTION:
# Same as "emake", but set up the Xvfb hack if needed.
Xemake() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${EAPI} == [2345] ]] \
		|| die "${FUNCNAME} is unsupported in EAPI > 5, please use 'virtx emake ....'"

	VIRTUALX_COMMAND="emake" virtualmake "$@"
}

# @FUNCTION: Xeconf
# @DESCRIPTION:
# Same as "econf", but set up the Xvfb hack if needed.
Xeconf() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${EAPI} == [2345] ]] \
		|| die "${FUNCNAME} is unsupported in EAPI > 5, please use 'virtx econf ....'"

	VIRTUALX_COMMAND="econf" virtualmake "$@"
}

_VIRTUAL_X=1
fi
