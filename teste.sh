install_video_cards() {
	sudo pacman -S --needed --noconfirm "dmidecode"
	echo "VIDEO CARD"
	check_vga
  #Optimus {{{
	if [[ ${VIDEO_DRIVER} == optimus ]]; then
		XF86_DRIVERS=$(pacman -Qe | grep xf86-video | awk '{print $1}')
		[[ -n $XF86_DRIVERS ]] && pacman -Rcsn "$XF86_DRIVERS"
		read_input_text "Use NVIDIA PRIME Render Offload instead of Bumblebee?" "$BUMBLEBEE"
		if [[ $OPTION == y ]]; then
			sudo pacman -S --needed --noconfirm "nvidia nvidia-utils libglvnd nvidia-prime"
			sudo pacman -S --needed --noconfirm "mesa mesa-libgl libvdpau-va-gl"
			[[ ${ARCHI} == x86_64 ]] && pacman -S --needed lib32-virtualgl lib32-nvidia-utils
			replace_line '*options nouveau modeset=1' '#options nouveau modeset=1' /etc/modprobe.d/modprobe.conf
			replace_line '*MODULES="nouveau"' '#MODULES="nouveau"' /etc/mkinitcpio.conf
			create_ramdisk_environment
		else
			sudo pacman -S --needed --noconfirm xf86-video-intel bumblebee nvidia
			[[ ${ARCHI} == x86_64 ]] && pacman -S --needed lib32-virtualgl lib32-nvidia-utils
			replace_line '*options nouveau modeset=1' '#options nouveau modeset=1' /etc/modprobe.d/modprobe.conf
			replace_line '*MODULES="nouveau"' '#MODULES="nouveau"' /etc/mkinitcpio.conf
			create_ramdisk_environment
			add_user_to_group "${username}" bumblebee
		fi
	#}}}
	#NVIDIA {{{
	elif [[ ${VIDEO_DRIVER} == nvidia ]]; then
		XF86_DRIVERS=$(pacman -Qe | grep xf86-video | awk '{print $1}')
		[[ -n $XF86_DRIVERS ]] && sudo pacman -Rcsn --noconfirm "$XF86_DRIVERS"
		if [ "$(ls /boot | grep hardened -c)" -gt "0" ] || [ "$(ls /boot | grep lts -c)" -gt "0" ] || [ "$(ls /boot | grep zen -c)" -gt "0" ]; then
			sudo pacman -S --needed --noconfirm "nvidia-dkms nvidia-utils libglvnd"
			echo "Do not forget to make a mkinitcpio every time you updated the nvidia driver!"
		else
			sudo pacman -S --needed --noconfirm "nvidia nvidia-utils libglvnd"
		fi
		[[ ${ARCHI} == x86_64 ]] && pacman -S --needed lib32-nvidia-utils
		replace_line '*options nouveau modeset=1' '#options nouveau modeset=1' /etc/modprobe.d/modprobe.conf
		replace_line '*MODULES="nouveau"' '#MODULES="nouveau"' /etc/mkinitcpio.conf
		create_ramdisk_environment
		nvidia-xconfig --add-argb-glx-visuals --allow-glx-with-composite --composite --render-accel -o /etc/X11/xorg.conf.d/20-nvidia.conf
	#}}}
	#Nouveau [NVIDIA] {{{
	elif [[ ${VIDEO_DRIVER} == nouveau ]]; then
		is_package_installed "nvidia" && pacman -Rdds --noconfirm nvidia{,-utils}
		[[ ${ARCHI} == x86_64 ]] && is_package_installed "lib32-nvidia-utils" && pacman -Rdds --noconfirm lib32-nvidia-utils
		[[ -f /etc/X11/xorg.conf.d/20-nvidia.conf ]] && rm /etc/X11/xorg.conf.d/20-nvidia.conf
		sudo pacman -S --needed --noconfirm "xf86-video-${VIDEO_DRIVER} mesa-libgl libvdpau-va-gl"
		replace_line '#*options nouveau modeset=1' 'options nouveau modeset=1' /etc/modprobe.d/modprobe.conf
		replace_line '#*MODULES="nouveau"' 'MODULES="nouveau"' /etc/mkinitcpio.conf
		create_ramdisk_environment
	#}}}
	#ATI {{{
	elif [[ ${VIDEO_DRIVER} == ati ]]; then
		[[ -f /etc/X11/xorg.conf.d/20-radeon.conf ]] && rm /etc/X11/xorg.conf.d/20-radeon.conf
		[[ -f /etc/X11/xorg.conf ]] && rm /etc/X11/xorg.conf
		sudo pacman -S --needed --noconfirm "xf86-video-${VIDEO_DRIVR} mesa-libgl mesa-vdpau libvdpau-va-gl"
		add_module "radeon" "ati"
		create_ramdisk_environment
	#}}}
	#AMDGPU {{{
	elif [[ ${VIDEO_DRIVER} == amdgpu ]]; then
		[[ -f /etc/X11/xorg.conf.d/20-radeon.conf ]] && rm /etc/X11/xorg.conf.d/20-radeon.conf
		[[ -f /etc/X11/xorg.conf ]] && rm /etc/X11/xorg.conf
		sudo pacman -S --needed --noconfirm "xf86-video-${VIDEO_DRIVER} vulkan-radeon mesa-libgl mesa-vdpau libvdpau-va-gl"
		add_module "amdgpu radeon" "ati"
		create_ramdisk_environment
	#}}}
	#Intel {{{
	elif [[ ${VIDEO_DRIVER} == intel ]]; then
		sudo pacman -S --needed --noconfirm "xf86-video-${VIDEO_DRIVER} mesa-libgl libvdpau-va-gl"
	#}}}
	#Vesa {{{
	else
		sudo pacman -S --needed --noconfirm "xf86-video-${VIDEO_DRIVER} mesa-libgl libvdpau-va-gl"
	fi
	#}}}
	if [[ ${ARCHI} == x86_64 ]]; then
		is_package_installed "mesa-libgl" && sudo pacman -S --needed --noconfirm "lib32-mesa-libgl"
		is_package_installed "mesa-vdpau" && sudo pacman -S --needed --noconfirm "lib32-mesa-vdpau"
	fi
	if is_package_installed "libvdpau-va-gl"; then
		add_line "export VDPAU_DRIVER=va_gl" "/etc/profile"
	fi
}
