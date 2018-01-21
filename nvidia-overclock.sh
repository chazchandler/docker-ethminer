#!/usr/bin/env bash


# Overclocking with nvidia-settings
# Increase or decrease in small increments (+/- 25)


# GPUGraphicsClockOffset
#MY_CLOCK="150"
MY_CLOCK="100"

# GPUMemoryTransferRateOffset
#MY_MEM="600"
MY_MEM="800"

# GPUTargetFanSpeed (%)
MY_FAN="80"

MY_WATT="120"
MY_PM="0"

# Number of GPUs installed in this system
NUM_GPUS=$(nvidia-smi -L | grep ^GPU | wc -l)

MAX_CPU_FREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)

DISPLAY=":0"
XAUTHORITY="/var/run/lightdm/root/$DISPLAY"
export DISPLAY XAUTHORITY

for cpu in /sys/devices/system/cpu/cpu*/cpufreq
do
  echo 'echo "perfomance" > $cpu/scaling_governor'
  echo 'echo "$MAX_CPU_FREQ" > $cpu/scaling_min_freq'
done

# For each installed Graphics card
for MY_DEVICE in $(seq 0 $(($NUM_GPUS-1)))
do
	nvidia-smi -i $MY_DEVICE -pm $MY_PM
	nvidia-smi -i $MY_DEVICE -pl $MY_WATT

	# DISPLAY=:0 nvidia-settings -a "[gpu:$MY_DEVICE]/GPUPowerMizerMode=1"
	nvidia-settings -a "[gpu:$MY_DEVICE]/GPUPowerMizerMode=1"

	# Fan speed
	nvidia-settings -a "[gpu:$MY_DEVICE]/GPUFanControlState=1"
	nvidia-settings -a "[fan:$MY_DEVICE]/GPUTargetFanSpeed=$MY_FAN"

	# Graphics clock
	nvidia-settings -a "[gpu:$MY_DEVICE]/GPUGraphicsClockOffset[3]=$MY_CLOCK"

	# Memory clock
	nvidia-settings -a "[gpu:$MY_DEVICE]/GPUMemoryTransferRateOffset[3]=$MY_MEM"
done

echo
echo "Done"
echo
