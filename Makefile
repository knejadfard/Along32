# This makefile is to build the Along32 library and to install to the
# correct location for the sake of dynamic linking.
#
# Copyright (C) 2009 Curtis Wong.
# All right reserved.
# Email: airekans@gmail.com
# Homepage: http://along32.sourceforge.net
#
# Along32 library is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as 
# published by the Free Software Foundation, either version 3 of the
# License, or(at your option) any later version.
#
# Along32 library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with Along32 library.  If not, see <http://www.gnu.org/licenses/>.
#
#

# Assembler is NASM
ASM = nasm

# Format of object file is linux
LINUX_FORMAT = elf

# Flags used in assemblying phase
ASMFLAGS =

# Where to install. Default is /usr/lib
INSTDIR = /usr/lib

# Linker is ld
LINKER = ld

# Share libbrary option for linker
SHLIB = -shared

all: libAlong32.so

libAlong32.so: Along32.o
	$(LINKER) $(SHLIB) -m elf_i386 Along32.o -o libAlong32.so -lc

Along32.o: src/Along32.asm 
	$(ASM) -f $(LINUX_FORMAT) $(ASMFLAGS) -o Along32.o src/Along32.asm

clean:
	-rm Along32.o libAlong32.so

install: libAlong32.so
	@if [ -d $(INSTDIR) ]; \
	    then \
	    cp libAlong32.so $(INSTDIR);\
	    chmod a+x $(INSTDIR)/libAlong32.so;\
	    echo "Installed in $(INSTDIR)";\
	 else \
	    echo "Sorry, $(INSTDIR) does not exist";\
	 fi

uninstall:
	@if [ -d $(INSTDIR) ]; \
	    then \
	    rm $(INSTDIR)/libAlong32.so;\
	    echo "Uninstalling finished";\
	 else \
	    echo "Sorry, $(INSTDIR) does not exist";\
	 fi
