PATH := $(HOME)/projects/thirdparty/factor:$(PATH)

.PHONY: all
all:
	./update_blog_entries.sed
	./update_notes.factor
