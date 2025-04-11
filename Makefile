# Makefile for a simple C project

CC = gcc
CFLAGS = -Wall -Wextra -Iinclude
SRC_DIR = src
BUILD_DIR = build
TEST_DIR = tests
TARGET = $(BUILD_DIR)/main

SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRCS))

TEST_SRCS = $(wildcard $(TEST_DIR)/*.c)
TEST_OBJS = $(patsubst $(TEST_DIR)/%.c,$(BUILD_DIR)/%.test.o,$(TEST_SRCS))
TEST_TARGET = $(BUILD_DIR)/test_runner

.PHONY: all clean run test help

all: $(TARGET)

# Link object files to create the main executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Compile .c files into .o files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

run: all
	./$(TARGET)

test: $(TEST_TARGET)
	./$(TEST_TARGET)

$(TEST_TARGET): $(TEST_OBJS) $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

$(BUILD_DIR)/%.test.o: $(TEST_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)/*.o $(TARGET) $(TEST_TARGET)

help:
	@echo "Usage:"
	@echo "  make        - Build the project"
	@echo "  make run    - Run the main binary"
	@echo "  make test   - Compile and run tests"
	@echo "  make clean  - Remove build artifacts"
