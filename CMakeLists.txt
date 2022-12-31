cmake_minimum_required(VERSION 3.22)

project(
	YeebsSkyrimMods
	VERSION 1.0.0
	LANGUAGES CXX
)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if("${PROJECT_SOURCE_DIR}" STREQUAL "${PROJECT_BINARY_DIR}")
	message(FATAL_ERROR "in-source builds are not allowed")
endif()

macro(set_from_environment VARIABLE)
	if(NOT DEFINED ${VARIABLE} AND DEFINED ENV{${VARIABLE}})
		set(${VARIABLE} $ENV{${VARIABLE}})
	endif()
endmacro()

set_from_environment(SkyblivionDir)
if(NOT DEFINED SkyblivionDir)
	message(FATAL_ERROR "SkyblivionDir is not set")
endif()
set_from_environment(SkywindDir)
if(NOT DEFINED SkywindDir)
	message(FATAL_ERROR "SkywindDir is not set")
endif()

option(COPY_OUTPUT "copy the output of build operations to the game directory" OFF)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

add_subdirectory(skyblivion_classcreation)
add_subdirectory(skyblivion_spellcrafting)
add_subdirectory(skywind_chargenstuff)
add_subdirectory(skywind_classcreation)
include(cmake/packaging.cmake)
