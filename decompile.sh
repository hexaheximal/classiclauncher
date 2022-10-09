#!/bin/bash

if [ ! -d input ]
then
	mkdir input
fi

if [ ! -d output ]
then
	mkdir output
fi

if [ ! -f input/Minecraft.jar ]
then
	echo "Downloading launcher..."
	
	wget https://web.archive.org/web/20101008032307/http://www.minecraft.net/download/Minecraft.jar?v=1286508187877 -O input/Minecraft.jar
fi

if [ ! -d tools/jdk8u345-b01 ]
then
	echo "Downloading OpenJDK..."
	
	wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u345-b01/OpenJDK8U-jdk_x64_linux_hotspot_8u345b01.tar.gz -O /tmp/jdk8.tar.gz
	tar -xf /tmp/jdk8.tar.gz -C tools
	rm /tmp/jdk8.tar.gz
fi

echo "Decompiling with Fernflower..."

java -jar tools/fernflower.jar input/Minecraft.jar /tmp

unzip -d src /tmp/Minecraft.jar

rm /tmp/Minecraft.jar

echo "Removing unnecessary files..."

rm -r src/META-INF
rm src/java.policy.applet

echo "Applying patches..."

patch -p1 -ruN -d src < tools/launcher_fix.patch
patch -p1 -ruN -d src < tools/launcher_mod.patch
