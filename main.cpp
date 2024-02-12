#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN

#include "doctest/doctest.h"

std::string world() {
    return "World";
}

#pragma clang diagnostic ignored "-Woverloaded-shift-op-parentheses"

TEST_CASE("Hello") {
    CHECK(world() == "World");
}