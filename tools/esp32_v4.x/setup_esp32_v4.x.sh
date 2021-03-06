#!/bin/bash

BSP_NAME=${1}

git submodule status bsp/${BSP_NAME} &> /dev/null
if [ "$?" == "0" ]; then
	cd bsp/${BSP_NAME}
	git am ../../patches/${BSP_NAME}/*.patch
else
	if [ "$(ls bsp/${BSP_NAME})" == "" ]; then
		echo "Failed to find source code in bsp/${BSP_NAME}"
	else
		cd bsp/${BSP_NAME}
		for patch in ../../patches/${BSP_NAME}/*
			do patch -f -p1 < ${patch}
		done
	fi
	echo "Check source code in bsp/${BSP_NAME}"
fi

