# 
# Copyright (c) Andy Yu and Yunze Zhou
# Sharing and altering of the source code is restricted under the MIT License.
#

default: main

COMPILER = clang++ -std=c++2a

BIN_DIR = bin
INCLUDE_DIR = include
SRC_DIR = src
TESTS_DIR = tests

TESTING_FLAGS = -g -DDEBUG
WARNINGS_FLAGS = -Wall -Wextra -Wstrict-prototypes -Wreorder

SRC_FILES = $(wildcard $(SRC_DIR)/*.cpp)

EXECUTABLE = luminous

FORMATTER = clang-format
FORMATTER_FLAGS = -i -style=Google
FORMATER_FILES = $(wildcard $(SRC_DIR)/*.cpp $(INCLUDE_DIR)/*.hpp)

format:
	$(FORMATTER) $(FORMATTER_FLAGS) $(FORMATER_FILES)

setup:
	$(MAKE) format
	mkdir -p $(BIN_DIR)

main:
	$(MAKE) setup
	$(COMPILER) -o $(BIN_DIR)/$(EXECUTABLE) -Iinclude $(SRC_FILES) $(WARNINGS_FLAGS)

debug:
	$(MAKE) setup	
	$(COMPILER) -o $(BIN_DIR)/$(EXECUTABLE) -Iinclude $(SRC_FILES) $(WARNINGS_FLAGS) $(TESTING_FLAGS)
	gdb ./$(BIN_DIR)/$(EXECUTABLE)

basic:
	./$(BIN_DIR)/$(EXECUTABLE) ./$(TESTS_DIR)/basic.in

io:
	@bash ./io-test.sh

memory:
	@bash ./memory-test.sh

test:
	$(MAKE) main
	$(MAKE) io

clean:
	rm -r $(BIN_DIR)

gdb:
	gdb ./$(BIN_DIR)/$(EXECUTABLE)

repl:
	./$(BIN_DIR)/$(EXECUTABLE) 
