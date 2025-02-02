ifeq ($(.DEFAULT_GOAL),)
# Define default goal to `all` because this file defines some targets
# before the inclusion of erlang.mk leading to the wrong target becoming
# the default.
.DEFAULT_GOAL = all
endif

# PROJECT_VERSION defaults to:
#   1. the version exported by rabbitmq-server-release;
#   2. the version stored in `git-revisions.txt`, if it exists;
#   3. a version based on git-describe(1), if it is a Git clone;
#   4. 0.0.0

PROJECT_VERSION := $(RABBITMQ_VERSION)

ifeq ($(PROJECT_VERSION),)
PROJECT_VERSION := $(shell \
if test -f git-revisions.txt; then \
	head -n1 git-revisions.txt | \
	awk '{print $$$(words $(PROJECT_DESCRIPTION) version);}'; \
else \
	(git describe --dirty --abbrev=7 --tags --always --first-parent \
	 2>/dev/null || echo rabbitmq_v0_0_0) | \
	sed -e 's/^rabbitmq_v//' -e 's/^v//' -e 's/_/./g' -e 's/-/+/' \
	 -e 's/-/./g'; \
fi)
endif

# --------------------------------------------------------------------
# RabbitMQ components.
# --------------------------------------------------------------------

dep_amqp10_client                     = hex $(PROJECT_VERSION)
dep_amqp10_common                     = hex $(PROJECT_VERSION)
dep_amqp_client                       = hex $(PROJECT_VERSION)
dep_rabbit_common                     = hex $(PROJECT_VERSION)

# Third-party dependencies version pinning.
dep_accept = hex 0.3.5
dep_cowboy = hex 2.10.0
dep_cowlib = hex 2.12.1
dep_credentials_obfuscation = hex 3.4.0
dep_prometheus = hex 4.10.0
dep_ra = hex 2.6.3
dep_ranch = hex 2.1.0
dep_recon = hex 2.5.3
dep_redbug = hex 2.0.7
dep_thoas = hex 1.0.0
dep_observer_cli = hex 1.7.3
dep_stdout_formatter = hex 0.2.4
dep_sysmon_handler = hex 1.3.0
