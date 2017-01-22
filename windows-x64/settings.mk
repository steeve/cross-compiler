MXE_TARGETS := x86_64-w64-mingw32.static
LOCAL_PKG_LIST := gcc
.DEFAULT local-pkg-list:
local-pkg-list: $(LOCAL_PKG_LIST)
