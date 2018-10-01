LDFLAGS += -lliquid -liio -lad9361 -lc -lm -lfftw3 -lfftw3f -lini -lusb-1.0 \
-lserialport -lavahi-client -lavahi-common -lxml2 -lz -ldbus-1 -lfec -ltuntap

SRC := $(wildcard *.c)
OBJ := $(addprefix build/,$(SRC:.c=.o))

bin/charon: $(OBJ)
	@mkdir -p $(@D)
	@$(CC) $(CXXFLAGS) $(CFLAGS) $^ $(LDFLAGS) -o $@

build/%.o: %.c
	@mkdir -p $(@D)
	@$(CC) $(CXXFLAGS) $(CFLAGS) -MMD -MP -fPIC -c $< -o $@

.PHONY: clean
clean:
	@rm -rf build bin

-include: $(OBJ:.o=.d)
