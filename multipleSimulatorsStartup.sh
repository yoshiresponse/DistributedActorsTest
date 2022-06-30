{\rtf1\ansi\ansicpg1252\cocoartf2684
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica-Oblique;\f1\fswiss\fcharset0 Helvetica-BoldOblique;}
{\colortbl;\red255\green255\blue255;\red31\green31\blue31;\red255\green255\blue255;}
{\*\expandedcolortbl;;\cssrgb\c16078\c16078\c16078;\cssrgb\c100000\c100000\c100000;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\i\fs42 \AppleTypeServices\AppleTypeServicesF65539 \cf2 \cb3 \expnd0\expndtw0\kerning0
# installs and lanches the `bundle_id` for the specified simulator device\cb1 \
\cb3 installAndLaunch() \{\cb1 \
\cb3 device=$1\cb1 \
\cb3 app_path=$2\cb1 \
\cb3 app_bundle_id=$3\cb1 \
\cb3 xcrun instruments -w \'93$device\'94\cb1 \
\cb3 xcrun simctl install $device $path\cb1 \
\cb3 xcrun simctl launch $device $bundle_id &\cb1 \
\cb3 \}\cb1 \
\cb3 # parses the configuration file\cb1 \
\cb3 source ./multipleSimulators.config\cb1 \
\cb3 echo \'93testing: source $app_location\'94\cb1 \
\cb3 path=$(find $app_location -name \'93
\f1\b \AppleTypeServices\AppleTypeServicesF65539 TicTacFish
\f0\b0 \AppleTypeServices\AppleTypeServicesF65539 .app\'94 | head -n 1)\cb1 \
\cb3 echo \'93Application found at: $path\'94\cb1 \
\cb3 echo \'93<<<<<<<<<<<<<<<<<<< Initializing all simulators >>>>>>>>>>>>>>>>>>>>\'94\cb1 \
\cb3 # iterates over the simulators list and start installation / launching process\cb1 \
\cb3 IFS=\'92,\'92 read -ra ADDR <<< \'93$simulators_list\'94\cb1 \
\cb3 for device in \'93$\{ADDR[@]\}\'94; do\cb1 \
\cb3 installAndLaunch $device $path $bundle_id &\cb1 \
\cb3 done}