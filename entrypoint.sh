#!/bin/sh

# LABEL name="ye3tftp" version="1.0.0" author="palw3ey" maintainer="palw3ey" email="palw3ey@gmail.com" website="https://github.com/palw3ey/ye3tftp" license="MIT" create="20231202" update="20231203"

# Entrypoint for docker

# ============ [ global variable ] ============

vg_chmod_option=""
vg_create_option=""

# ============ [ function ] ============

# echo information for docker logs
function f_log(){
  echo -e "$(date '+%Y-%m-%d %H:%M:%S') $(hostname) ye3radius: $@"
}

# ============ [ internationalisation ] ============

if [[ -f /i18n/$Y_LANGUAGE.sh ]]; then
	f_log "i18n $Y_LANGUAGE"
	source /i18n/$Y_LANGUAGE.sh
else
	f_log "i18n fr_FR"
	source /i18n/fr_FR.sh
fi

# ============ [ config ] ============

# apply chmod if specified
if [[ ! -z "$Y_CHMOD" ]]; then
	f_log "$i_apply chmod"
	if [[ $Y_CHMOD_RECURSIVE == "yes" ]]; then
		f_log "$i_recursive"
		vg_chmod_option="-R"
	fi
	chmod $Y_CHMOD $vg_chmod_option /data/*
fi

# check if create is enabled
if [[ $Y_CREATE == "yes" ]]; then
	f_log "$i_enable create"
	vg_create_option="--create"
fi

# ============ [ start service ] ============

f_log "$i_start in.tftpd"

if [[ $Y_DEBUG == "yes" ]]; then
	f_log "$i_with_debug_option"
	/usr/sbin/in.tftpd --foreground --secure $vg_create_option --address $Y_IP:$Y_PORT --verbosity 4 /data &
else
	/usr/sbin/in.tftpd --foreground --secure $vg_create_option --address $Y_IP:$Y_PORT /data &
fi

f_log ":: $i_ready ::"

# keep the server running
tail -f /dev/null
