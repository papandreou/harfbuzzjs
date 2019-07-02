#!/bin/bash

# [ -d harfbuzz ] || git clone --depth=1 https://github.com/harfbuzz/harfbuzz
# (cd harfbuzz; git pull)

# Or, -DHB_EXTERN=__attribute__((used))
clang \
    -I../libc/include -Oz \
	-fno-exceptions -fno-rtti -fno-threadsafe-statics -fvisibility-inlines-hidden \
	--target=wasm32 \
	-nostdlib -nostdinc \
	-flto \
	-DHB_TINY -DHB_USE_INTERNAL_QSORT \
	-Wl,--no-entry \
	-Wl,--strip-all \
	-Wl,--lto-O3 \
	-Wl,--gc-sections \
	-Wl,--export=malloc \
	-Wl,--export=hb_blob_create \
	-Wl,--export=hb_face_create \
	-Wl,--export=hb_set_create \
	-Wl,--export=hb_set_add \
	-Wl,--export=hb_subset_input_create_or_fail \
	-Wl,--export=hb_subset_input_glyph_set \
	-Wl,--export=hb_set_union \
	-Wl,--export=hb_subset_input_set_drop_hints \
	-Wl,--export=hb_subset \
	-Wl,--export=hb_subset_input_destroy \
	-Wl,--export=hb_face_reference_blob \
	-Wl,--export=hb_blob_get_data \
	-Wl,--export=hb_blob_destroy \
	-Wl,--export=hb_face_destroy \
	-Wl,--export=free \
	../libc/emmalloc.cpp ../libc/zephyr-string.c ../libc/main.c ../harfbuzz/src/hb-*.cc
mv a.out hb-subset.wasm
