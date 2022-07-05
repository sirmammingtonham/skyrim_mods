set(ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/..")

set(SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
file(GLOB SOURCE_FILES src/*.cpp src/*.h)

source_group(TREE "${CMAKE_CURRENT_SOURCE_DIR}" FILES ${SOURCE_FILES})

file(GLOB CLIK_FILES ../external/CLIK/*.cpp ../external/CLIK/CLIK/*.h)

source_group(TREE "${ROOT_DIR}/external" FILES ${CLIK_FILES})

set(VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/src/Plugin.h")
configure_file(
	"${ROOT_DIR}/cmake/Plugin.h.in"
	"${VERSION_HEADER}"
	@ONLY
)

source_group("src" FILES "${VERSION_HEADER}")

configure_file(
	"${ROOT_DIR}/cmake/version.rc.in"
	"${CMAKE_CURRENT_BINARY_DIR}/version.rc"
	@ONLY
)

get_filename_component(SUBPROJ_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" SUBPROJ_NAME ${SUBPROJ_NAME})

add_library(
	"${SUBPROJ_NAME}"
	SHARED
	${SOURCE_FILES}
	${CLIK_FILES}
	"${VERSION_HEADER}"
	"${CMAKE_CURRENT_BINARY_DIR}/version.rc"
	"${ROOT_DIR}/.clang-format"
	"${ROOT_DIR}/.editorconfig"
)

target_compile_features(
	"${SUBPROJ_NAME}"
	PRIVATE
		cxx_std_20
)

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
	target_compile_options(
		"${SUBPROJ_NAME}"
		PRIVATE
			"/sdl"	# Enable Additional Security Checks
			"/utf-8"	# Set Source and Executable character sets to UTF-8
			"/Zi"	# Debug Information Format

			"/permissive-"	# Standards conformance
			"/Zc:preprocessor"	# Enable preprocessor conformance mode

			"/wd4200" # nonstandard extension used : zero-sized array in struct/union

			"$<$<CONFIG:DEBUG>:>"
			"$<$<CONFIG:RELEASE>:/Zc:inline;/JMC-;/Ob3>"
	)

	target_link_options(
		"${SUBPROJ_NAME}"
		PRIVATE
			"$<$<CONFIG:DEBUG>:/INCREMENTAL;/OPT:NOREF;/OPT:NOICF>"
			"$<$<CONFIG:RELEASE>:/INCREMENTAL:NO;/OPT:REF;/OPT:ICF;/DEBUG:FULL>"
	)
endif()

target_include_directories(
	"${SUBPROJ_NAME}"
	PRIVATE
		"${ROOT_DIR}/external/CLIK"
		"${CMAKE_CURRENT_BINARY_DIR}/src"
		"${SOURCE_DIR}"
)
if (NOT TARGET CommonLibSSE)
	add_subdirectory("${ROOT_DIR}/external/CommonLibSSE" CommonLibSSE EXCLUDE_FROM_ALL)
endif()

target_link_libraries(
	"${SUBPROJ_NAME}"
	PRIVATE
		CommonLibSSE::CommonLibSSE
)

target_precompile_headers(
	"${SUBPROJ_NAME}"
	PRIVATE
		"${SOURCE_DIR}/PCH.h"
)

install(
	FILES
		"$<TARGET_FILE:${SUBPROJ_NAME}>"
	DESTINATION "SKSE/Plugins"
	COMPONENT "main"
)

install(
	FILES
		"$<TARGET_PDB_FILE:${SUBPROJ_NAME}>"
	DESTINATION "/"
	COMPONENT "pdbs"
)

if("${COPY_OUTPUT}")
	add_custom_command(
		TARGET "${SUBPROJ_NAME}"
		POST_BUILD
		# COMMAND "${CMAKE_COMMAND}" -E copy_if_different "$<TARGET_FILE:${SUBPROJ_NAME}>" "${SkywindDir}/SKSE/Plugins/"
		# COMMAND "${CMAKE_COMMAND}" -E copy_if_different "$<TARGET_PDB_FILE:${SUBPROJ_NAME}>" "${SkywindDir}/SKSE/Plugins/"
		COMMAND "${CMAKE_COMMAND}" -E copy_if_different "$<TARGET_FILE:${SUBPROJ_NAME}>" "E:/MO2/_Skyrim/mods/Skyblivion UI Tests/SKSE/plugins"
		COMMAND "${CMAKE_COMMAND}" -E copy_if_different "$<TARGET_PDB_FILE:${SUBPROJ_NAME}>" "E:/MO2/_Skyrim/mods/Skyblivion UI Tests/SKSE/plugins"
		VERBATIM
	)
endif()
