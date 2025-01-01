cmake_minimum_required(VERSION 3.10)
project(guess-the-number-game)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

add_executable(game src/main.cpp src/game.cpp)

target_include_directories(game PUBLIC include)
