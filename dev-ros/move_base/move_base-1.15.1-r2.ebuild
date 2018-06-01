# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
ROS_REPO_URI="https://github.com/ros-planning/navigation"
ROS_SUBDIR=${PN}
KEYWORDS="~amd64 ~arm"
PYTHON_COMPAT=( python2_7 )

inherit ros-catkin

DESCRIPTION="Given a goal in the world, will attempt to reach it with a mobile base"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
	>=dev-ros/costmap_2d-1.15.1
	dev-ros/roscpp
	dev-ros/pluginlib
		dev-libs/tinyxml2:=
	dev-ros/actionlib
	dev-ros/base_local_planner
	dev-ros/clear_costmap_recovery
	dev-ros/navfn
	dev-ros/rotate_recovery
	dev-ros/dynamic_reconfigure[${PYTHON_USEDEP}]
	dev-ros/nav_core
	dev-ros/tf
	dev-ros/move_base_msgs[${CATKIN_MESSAGES_CXX_USEDEP}]
	dev-ros/std_srvs[${CATKIN_MESSAGES_CXX_USEDEP}]
	dev-cpp/eigen:3
	dev-libs/boost:=
	dev-libs/console_bridge:=
"
DEPEND="${RDEPEND}
	dev-ros/cmake_modules"
