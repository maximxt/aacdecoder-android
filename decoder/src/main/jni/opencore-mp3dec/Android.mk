#
# Compile OpenCORE aacdec - retrieved from Android's GIT repo.
# 

# Set up the PV variables
include $(PV_TOP)/Config.mk

my_LOCAL_PATH := $(call my-dir)
LOCAL_PATH := $(OPENCORE_MP3)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/pvmp3_alias_reduction.cpp \
	src/pvmp3_crc.cpp \
	src/pvmp3_dct_16.cpp \
	src/pvmp3_dct_6.cpp \
	src/pvmp3_dct_9.cpp \
	src/pvmp3_decode_header.cpp \
	src/pvmp3_decode_huff_cw.cpp \
	src/pvmp3_decoder.cpp \
	src/pvmp3_dequantize_sample.cpp \
	src/pvmp3_equalizer.cpp \
	src/pvmp3_framedecoder.cpp \
	src/pvmp3_get_main_data_size.cpp \
	src/pvmp3_get_scale_factors.cpp \
	src/pvmp3_get_side_info.cpp \
	src/pvmp3_getbits.cpp \
	src/pvmp3_huffman_decoding.cpp \
	src/pvmp3_huffman_parsing.cpp \
	src/pvmp3_imdct_synth.cpp \
	src/pvmp3_mdct_18.cpp \
	src/pvmp3_mdct_6.cpp \
	src/pvmp3_mpeg2_get_scale_data.cpp \
	src/pvmp3_mpeg2_get_scale_factors.cpp \
	src/pvmp3_mpeg2_stereo_proc.cpp \
	src/pvmp3_normalize.cpp \
	src/pvmp3_poly_phase_synthesis.cpp \
	src/pvmp3_polyphase_filter_window.cpp \
	src/pvmp3_reorder.cpp \
	src/pvmp3_seek_synch.cpp \
	src/pvmp3_stereo_proc.cpp \
	src/pvmp3_tables.cpp

ifeq ($(TARGET_ARCH),arm)
LOCAL_SRC_FILES += \
	src/asm/pvmp3_dct_16_gcc.s \
	src/asm/pvmp3_dct_9_gcc.s \
	src/asm/pvmp3_mdct_18_gcc.s \
	src/asm/pvmp3_polyphase_filter_window_gcc.s
else
LOCAL_SRC_FILES += \
	src/pvmp3_dct_16.cpp \
	src/pvmp3_dct_9.cpp \
	src/pvmp3_mdct_18.cpp \
	src/pvmp3_polyphase_filter_window.cpp
endif

 	
#src/../util/getactualaacconfig/src/getactualaacconfig.cpp


PV_INCLUDES	:= $(PV_INCLUDES) \
				$(PV_TOP)/oscl/oscl/osclbase/src \
				$(PV_TOP)/oscl/oscl/osclmemory/src \
				$(PV_TOP)/oscl/oscl/osclerror/src

#$(PV_TOP)/codecs_v2/audio/aac/dec/util/getactualaacconfig/include


LOCAL_MODULE := libpv_mp3_dec

ifeq ($(TARGET_ARCH),arm)
  LOCAL_CFLAGS := -DPV_ARM_GCC_V4 $(PV_CFLAGS)
  LOCAL_ARM_MODE := arm
else
  LOCAL_CFLAGS :=  $(PV_CFLAGS)
endif

LOCAL_CPPFLAGS := -Wno-deprecated-register

LOCAL_STATIC_LIBRARIES := 

LOCAL_SHARED_LIBRARIES := 

LOCAL_C_INCLUDES := \
	$(PV_TOP)/codecs_v2/audio/mp3/dec/src \
 	$(PV_TOP)/codecs_v2/audio/mp3/dec/include \
 	$(PV_INCLUDES)

LOCAL_COPY_HEADERS_TO := $(PV_COPY_HEADERS_TO)

LOCAL_COPY_HEADERS := \
	include/pvmp3_decoder.h \
	include/pvmp3_decoder_api.h \
	include/pvmp3_audio_type_defs.h

include $(BUILD_STATIC_LIBRARY)
