#!/usr/bin/env bash
# Copyright (C) 2019 Ahmad Thoriq Najahi (najahiiii) 😘
#
# Telegram FUNCTION begin
#
git clone https://github.com/fabianonline/telegram.sh telegram

TELEGRAM_ID=${chat_id}
TELEGRAM_TOKEN=${token}
TELEGRAM=telegram/telegram

export TELEGRAM_TOKEN

# Push kernel installer to channel
function push() {
	ZIP=$(echo SiMontok*.zip)
	curl -F document=@$ZIP  "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendDocument" \
			-F chat_id="${TELEGRAM_ID}"
}

# Send the info up
function tg_channelcast() {
	"${TELEGRAM}" -c ${TELEGRAM_ID} -H \
		"$(
			for POST in "${@}"; do
				echo "${POST}"
			done
		)"
}

function tg_sendinfo() {
	curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
		-d "parse_mode=markdown" \
		-d text="${1}" \
		-d chat_id="${TELEGRAM_ID}" \
		-d "disable_web_page_preview=true"
}

# Fin Error
function finerr() {
	curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
		-d "parse_mode=markdown" \
		-d text="Build throw an error(s)" \
		-d chat_id="${TELEGRAM_ID}" \
		-d "disable_web_page_preview=true"
	exit 1
}

# Send sticker
function tg_sendstick() {
	curl -s -F chat_id=${TELEGRAM_ID} -F sticker="CAADBQADbAADHlQ_IgwXuIBe7E5IFgQ" https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendSticker
}

# Fin prober
function fin() {
	tg_sendinfo "$(echo "Build took $((${DIFF} / 60)) minute(s) and $((${DIFF} % 60)) seconds.")"
}

# Clean stuff
function clean() {
	rm -rf out Gas-Build/AnyKernel2/SiMontok* Gas-Build/AnyKernel2/zImage
}

#
# Telegram FUNCTION end
#

# Main environtment
KERNEL_DIR="$(pwd)"
KERN_IMG="$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb"
ZIP_DIR="$KERNEL_DIR/Gas-Build/AnyKernel2"
CONFIG="rolex_defconfig"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
THREAD="-j32"
LOAD="-l32"
ARM="arm64"
CC="$(pwd)/clang/bin/clang"
CT="aarch64-linux-gnu-"
GCC="$(pwd)/gcc/bin/aarch64-linux-gnu-"
GCC32="$(pwd)/gcc32/bin/arm-linux-gnueabi-"

# Export
export ARCH=arm64
export KBUILD_BUILD_USER=Keizzn
export KBUILD_BUILD_HOST=NusantaraDevs

# Build start
tanggal=$(TZ=Asia/Jakarta date +'%H%M-%d%m%y')
DATE=`date`
BUILD_START=$(date +"%s")

tg_sendstick

tg_channelcast "<b>SiMontok-Kernel-S</b> new build is up!" \
		"Started on BuildSlaves" \
		"For device <b>ROLEX</b> (Redmi 4A)" \
		"At branch <code>${BRANCH}</code>" \
                "Last commit <code>$(git log --pretty=format:'"%h : %s"' -1)</code>" \
                "Using Compiler: <code>$(${CC} --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')</code>" \
		"Compiled with: <code>$(${GCC32}gcc --version | head -n 1)</code>" \
		"Compiled with: <code>$(${GCC}gcc --version | head -n 1)</code>" \
		"Started on <code>$(TZ=Asia/Jakarta date)</code>"

make -s -C $(pwd) ${THREAD} ${LOAD} O=out ${CONFIG}
make -C $(pwd) ${THREAD} ${LOAD} 2>&1 O=out \
			       	      ARCH=${ARM} \
                        	      CC=${CC} \
       		        	      CLANG_TRIPLE=${CT} \
                     		      CROSS_COMPILE_ARM32=${GCC32} \
				      CROSS_COMPILE=${GCC}

if ! [ -a ${KERN_IMG} ]; then
	finerr
	exit 1
fi

cp ${KERN_IMG} ${ZIP_DIR}/zImage
cd ${ZIP_DIR}
zip -r9 SiMontok-S-NusantaraTC-${tanggal}.zip *
BUILD_END=$(date +"%s")
DIFF=$((${BUILD_END} - ${BUILD_START}))
push
cd ../..
fin
clean
# Build end
