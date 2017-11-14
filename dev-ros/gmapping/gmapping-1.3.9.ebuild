# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
ROS_REPO_URI="https://github.com/ros-perception/slam_gmapping"
KEYWORDS="~amd64 ~arm"
ROS_SUBDIR=${PN}

inherit ros-catkin

DESCRIPTION="ROS wrapper for OpenSlam's Gmapping"
LICENSE="CC-BY-NC-SA-2.5"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/boost:=
	dev-ros/nav_msgs[${CATKIN_MESSAGES_CXX_USEDEP}]
	dev-ros/roscpp
	dev-ros/tf
	dev-ros/openslam_gmapping
	dev-ros/rosbag_storage
"
DEPEND="${RDEPEND}
	dev-ros/rostest"
