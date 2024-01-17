CC      = wllvm
CFLAGS += -std=c99 -O0 -Xclang -disable-O0-optnone

PROGRAM = spectre
SOURCE  = spectre.c
     
all: $(PROGRAM)

GIT_SHELL_EXIT := $(shell git status --porcelain 2> /dev/null >&2 ; echo $$?)

# It can be non-zero when not in git repository or git is not installed.
# It can happen when downloaded using github's "Download ZIP" option.
ifeq ($(GIT_SHELL_EXIT),0)
# Check if working dir is clean.
GIT_STATUS := $(shell git status --porcelain)
ifndef GIT_STATUS
GIT_COMMIT_HASH := $(shell git rev-parse HEAD)
CFLAGS += -DGIT_COMMIT_HASH='"$(GIT_COMMIT_HASH)"'
endif
endif
     
$(PROGRAM): $(SOURCE) ; LLVM_COMPILER=clang $(CC) $(CFLAGS) -o $(PROGRAM) $(SOURCE)
     
clean: ; rm -f $(PROGRAM)
