micLightDevFile="/sys/devices/platform/thinkpad_acpi/leds/platform::micmute/brightness"
micLightMaxFile="/sys/devices/platform/thinkpad_acpi/leds/platform::micmute/max_brightness"

cmp --silent $micLightDevFile $micLightMaxFile && echo 0 > $micLightDevFile || echo 1 > $micLightDevFile

