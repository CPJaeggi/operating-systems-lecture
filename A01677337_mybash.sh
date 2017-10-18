#! /bin/bash
#-----------------------------------------------------------------
#| Written by: Cédric Paul Jäggi                                 |
#| About:      This Script should fulfill all the requirements   |
#|             given by the Email request of Mr. Rodriguez.      |
#| Code:       The code is mostly written in Bash.               |
#-----------------------------------------------------------------
#| VARIABLE SECTION                                              |
#-----------------------------------------------------------------
FILE_COUNT=$(find linux/ -type f | grep "*" | wc -l)
FILE_COUNT_ARCH=$(find linux/arch/ -type f | wc -l)
FILE_COUNT_CRYPTO=$(find linux/crypto/ -type f | wc -l)
FILE_COUNT_INCLUDE=$(find linux/include/ -type f | wc -l)
FILE_COUNT_KERNEL=$(find linux/kernel/ -type f | wc -l)
FILE_COUNT_NET=$(find linux/net/ -type f | wc -l)
FILE_COUNT_SOUND=$(find linux/sound/ -type f | wc -l)
FILE_COUNT_BLOCK=$(find linux/block/ -type f | wc -l)
FILE_COUNT_DOCUMENTATION=$(find linux/Documentation/ -type f | wc -l)
FILE_COUNT_INIT=$(find linux/init/ -type f | wc -l)
FILE_COUNT_LIB=$(find linux/lib/ -type f | wc -l)
FILE_COUNT_TOOLS=$(find linux/tools/ -type f | wc -l)
FILE_COUNT_CERTS=$(find linux/certs/ -type f | wc -l)
FILE_COUNT_DRIVERS=$(find linux/drivers/ -type f | wc -l)
FILE_COUNT_IPC=$(find linux/ipc/ -type f | wc -l)
FILE_COUNT_SAMPLES=$(find linux/samples/ -type f | wc -l)
FILE_COUNT_USR=$(find linux/usr/ -type f | wc -l)
FILE_COUNT_FIRMWARE=$(find linux/firmware/ -type f | wc -l)
FILE_COUNT_SCRIPTS=$(find linux/scripts/ -type f | wc -l)
FILE_COUNT_VIRT=$(find linux/virt/ -type f | wc -l)
FILE_COUNT_FS=$(find linux/fs/ -type f | wc -l)
FILE_COUNT_MM=$(find linux/mm/ -type f | wc -l)
FILE_COUNT_SECURITY=$(find linux/security/ -type f | wc -l)

FILE_COUNT_KERNEL_README=$(find linux/kernel/ -print | grep -i README | wc -l)
FILE_COUNT_KERNEL_KCONFIG=$(find linux/kernel/ -print | grep -i Kconfig | wc -l)
FILE_COUNT_KERNEL_KBUILD=$(find linux/kernel/ -print | grep -i Kbuild| wc -l)
FILE_COUNT_KERNEL_MAKEFILES=$(find linux/kernel/ -print | grep -i Makefile| wc -l)
FILE_COUNT_KERNEL_STARC=$(find linux/kernel/ -name *.c | wc -l)
FILE_COUNT_KERNEL_STARH=$(find linux/kernel/ -name *.h | wc -l)
FILE_COUNT_KERNEL_STARPL=$(find linux/kernel/ -name *.pl | wc -l)
FILE_COUNT_KERNEL_REST=$(($FILE_COUNT_KERNEL-$FILE_COUNT_KERNEL_README-$FILE_COUNT_KERNEL_KCONFIG-$FILE_COUNT_KERNEL_KBUILD-$FILE_COUNT_KERNEL_MAKEFILES-$FILE_COUNT_KERNEL_STARC-$FILE_COUNT_KERNEL_STARH-$FILE_COUNT_KERNEL_STARPL))

FILE_COUNT_C_FILES_STARC=$(find C_FILES/ -name *.c | wc -l)
FILE_COUNT_H_FILES_STARH=$(find H_FILES/ -name *.h | wc -l)




#-----------------------------------------------------------------
#| MAIN SECTION                                                  |
#-----------------------------------------------------------------


echo "------------------------------------------"
echo "|        Written by: Cédric Jäggi        |"
echo "------------------------------------------"
echo "|        Excercise B: 'File Count'       |"
echo "------------------------------------------"
echo "                                          "


echo "The Linux directory has: $FILE_COUNT files"
echo "# arch: $FILE_COUNT_ARCH"
echo "# crypto: $FILE_COUNT_CRYPTO"
echo "# include: $FILE_COUNT_INCLUDE"
echo "# kernel: $FILE_COUNT_KERNEL" 
echo "# net: $FILE_COUNT_NET" 
echo "# sound: $FILE_COUNT_SOUND" 
echo "# block: $FILE_COUNT_BLOCK" 
echo "# Documentation: $FILE_COUNT_Documentation" 
echo "# init: $FILE_COUNT_INIT" 
echo "# lib: $FILE_COUNT_LIB" 
echo "# tools: $FILE_COUNT_TOOLS" 
echo "# certs: $FILE_COUNT_CERTS" 
echo "# drivers: $FILE_COUNT_DRIVERS" 
echo "# ipc: $FILE_COUNT_IPC" 
echo "# samples: $FILE_COUNT_SAMPLES" 
echo "# usr: $FILE_COUNT_USR" 
echo "# firmware: $FILE_COUNT_FIRMWARE" 
echo "# scripts: $FILE_COUNT_SCRIPTS" 
echo "# virt: $FILE_COUNT_VIRT"
echo "# fs: $FILE_COUNT_FS" 
echo "# mm: $FILE_COUNT_MM" 
echo "# security: $FILE_COUNT_SECURITY" 


echo "                                          "
echo "------------------------------------------"
echo "|        Excercise c: 'Kernel files'     |"
echo "------------------------------------------"
echo "                                          " 

echo "In the Kernel directory there are: $FILE_COUNT_KERNEL files"
echo "# README-files: $FILE_COUNT_KERNEL_README"
echo "# Kconfig-files: $FILE_COUNT_KERNEL_KCONFIG"
echo "# KBuild-files: $FILE_COUNT_KERNEL_KBUILD"
echo "# Makefiles: $FILE_COUNT_KERNEL_MAKEFILES"
echo "# *c-files: $FILE_COUNT_KERNEL_STARC"
echo "# *h-files: $FILE_COUNT_KERNEL_STARH"
echo "# *pl-files: $FILE_COUNT_KERNEL_STARPL"
echo "# Other files: $FILE_COUNT_KERNEL_REST"


echo "                                          "
echo "------------------------------------------"
echo "|        Excercise d: 'Include files'    |"
echo "|        Excercise e:  'File copies'     |"
echo "------------------------------------------"
echo "                                          " 

#-----------------------------------------------------------------
#| "Sub-Script: one"                                             |
#-----------------------------------------------------------------
	
#-----------------------------------------------------------------
#| Folder Management                                             |
#--------------------------------------------------d---------------
	if [ -d C_FILES ];
	then
	  rm -R C_FILES
	  mkdir C_FILES
	else
	  mkdir C_FILES
	fi

	if [ -d H_FILES ];
	then
	  rm -R H_FILES
	  mkdir H_FILES
	else
	  mkdir H_FILES
	fi

#-----------------------------------------------------------------
#| Include Counter + Copy                                        |
#-----------------------------------------------------------------


C_FILE=$(find linux/ -type f | grep "\.c$")
H_FILE=$(find linux/ -type f | grep "\.h$")
for i in ${C_FILE[@]}
do
	cp -Rfx $i C_FILES/
done
for i in ${H_FILE[@]}
do
	cp -Rfx $i H_FILES/
done

declare -i FILE_COUNT_INCLUDELIB=0
for i in ${C_FILE[@]}
do
	if grep "#include <linux/module.h>" $i > tmp; then
		FILE_COUNT_INCLUDELIB=$((FILE_COUNT_INCLUDELIB + 1))
	fi
done

for i in ${H_FILE[@]}
do
	if grep "#include <linux/module.h>" $i >> tmp; then 			FILE_COUNT_INCLUDELIB=$((FILE_COUNT_INCLUDELIB + 1))
	fi
done

echo "# Number of times the #include <linux/module.h> appears = " $FILE_COUNT_INCLUDELIB

echo "                                          "
echo "------------------------------------------"
echo "|        Excercise e: 'Number of Files   |"
echo "------------------------------------------"
echo "                                          "

echo "# new archive *c-files: $FILE_COUNT_C_FILES_STARC"
echo "# new archive *h-files: $FILE_COUNT_H_FILES_STARH"




