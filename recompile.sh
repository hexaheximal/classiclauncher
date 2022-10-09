#!/bin/bash

echo "Compiling launcher..."

if [ ! -d bin ]
then
	mkdir bin
fi

./tools/jdk8u345-b01/bin/javac -d bin $(find -name "*.java" | grep minecraft)

if [ $? -ne 0 ]
then
	exit 1
fi

echo "Creating jar file..."

if [ ! -d bin/META-INF ]
then
	mkdir bin/META-INF
fi

printf "Manifest-Version: 1.2\nCreated-By: 1.6.0_17 (Sun Microsystems Inc.)\nMain-Class: net.minecraft.MinecraftLauncher\n" > bin/META-INF/MANIFEST.MF
printf "/* AUTOMATICALLY GENERATED ON Tue Apr 16 17:20:59 EDT 2002*/\n/* DO NOT EDIT */\n\ngrant {\n  permission java.security.AllPermission;\n};\n" > bin/java.policy.applet

cp src/net/minecraft/*.png bin/net/minecraft

cd bin

zip ../output/Minecraft.jar -r .

cd ..
