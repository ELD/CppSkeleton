# DEMO MAKEFILE
# Intended for future project usage with the C++ Application Skeleton

#####################################################################
# Flags
#####################################################################
CXXFLAGS +=
LDFLAGS +=
program_LIBRARIES_DIRS :=
program_INCLUDE_DIRS :=

#####################################################################
# Source Directories
#####################################################################
program_SRCDIR := src
program_HEADER_SRCDIR := headers
program_TEST_SRCDIR := tests
program_EXPERIMENTAL_SRCDIR := experimentals

#####################################################################
# Build Directory
#####################################################################
program_BUILDDIR := build

#####################################################################
# Targets
#####################################################################
program_TARGET_DIR := target
program_PRODUCTION_TARGET :=
program_TEST_TARGET :=
program_EXPERIMENTALS_TARGET :=

#####################################################################
# Sources and Source Extension
#####################################################################
program_SRCEXT := cpp
program_HEADEREXT := hpp
program_HEADER_SOURCES := $(shell find $(program_HEADER_SRCDIR) -type f -name *.$(program_HEADEREXT))
program_SOURCES := $(shell find $(program_SRCDIR) -type f -name *.$(program_SRCEXT))
program_TEST_SOURCES := $(shell find $(program_TEST_SRCDIR) -type f -name *.$(program_SRCEXT))
program_EXPERIMENTAL_SOURCES := $(shell find $(program_EXPERIMENTAL_SRCDIR) -type f -name *.$(program_SRCEXT))

#####################################################################
# Objects
#####################################################################
program_OBJECTS := $(patsubst $(program_SRCDIR)/%, $(program_BUILDDIR)/%, $(program_SOURCES:.$(program_SRCEXT)=.o))
program_TEST_OBJECTS := $(patsubst $(program_TEST_SRCDIR)/%, $(program_BUILDDIR)/%, $(program_TEST_SOURCES:.$(program_SRCEXT)=.o))
program_EXPERIMENTALS_OBJECTS := $(patsubst $(program_EXPERIMENTAL_SRCDIR)/%, $(program_BUILDDIR)/%, $(program_EXPERIMENTAL_SOURCES:.$(program_SRCEXT)=.o))

#####################################################################
# Targets
#####################################################################

.PHONY: all clean test experimentals todolist

$(program_TARGET): $(program_OBJECTS)
	$(CXX) $^ -o $(program_TARGET) $(program_LIBRARIES_DIR)

$(program_BUILDDIR)/%.o: $(program_SRCDIR)/%.$(program_SRCEXT)
	$(CXX) $(CXXFLAGS) $(program_INCLUDE_DIRS) -c -o $@ $<

todolist:
	-@for file in $(ALLFILES:Makefile=); do fgrep -H -e TODO -e FIXME $$file; done; true

clean:
	$(RM) $(wildcard $(program_OBJECTS) $(program_TEST_OBJECTS) $(program_EXPERIMENTAL_OBJECTS) \
	$(program_TARGET) $(program_TEST_TARGET) $(program_EXPERIMENTALS_TARGET))
