#install opencv4
DEPS_DIR="$HOME/dependencies"

function setPkgEnv {
	PKG_CONFIG_PATH=""
	for pkgdir in $DEPS_DIR/*/lib*/pkgconfig; do
		if [[ -d "$pkgdir" ]]; then
			PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$pkgdir"
		fi
	done
	export PKG_CONFIG_PATH
}

for script in install-flann.sh
do
	echo
	echo "running: bash $script $DEPS_DIR" && \
	setPkgEnv && \
	bash "$script" "$DEPS_DIR"
	if [[ $? != 0 ]]; then exit 1; fi
done
setPkgEnv
echo "all ok. Agregar el contenido de 'addToBashrc.sh' al .profile"

#Agregar el contenido al .profile
#DEPS_DIR="$HOME/dependencies"
#
#PKG_CONFIG_PATH=""
#for pkgdir in "$DEPS_DIR"/*/lib*/pkgconfig; do
#	if [[ -d "$pkgdir" ]]; then
#		PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$pkgdir"
#	fi
#done
#export PKG_CONFIG_PATH
#
#for bindir in "$DEPS_DIR"/*/bin*; do
#	if [[ -d "$bindir" ]]; then
#		PATH="${PATH}:$bindir"
#	fi
#done
#export PATH
