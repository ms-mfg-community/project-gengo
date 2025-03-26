# Tests CMakeLists.txt
find_package(GTest QUIET)

if(NOT GTEST_FOUND)
    # Download and build GoogleTest
    include(FetchContent)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG main
    )
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)
endif()

# Add test executable
add_executable(test_${PROJECT_NAME} test_thermostat.cpp)

target_link_libraries(test_${PROJECT_NAME}
    PRIVATE
        ${PROJECT_NAME}
        GTest::gtest_main
)

add_test(NAME ${PROJECT_NAME}_test COMMAND test_${PROJECT_NAME})
