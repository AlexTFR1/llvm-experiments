#include <gtest/gtest.h>

extern "C" int binarysearch(int array[], int length, int tosearch);

TEST(BinarySearch, empty) {
    int array[] = {0}; // cannot allocate an array of constant size 0
    ASSERT_GT(0, binarysearch(array, 0, 1));
    ASSERT_GT(0, binarysearch(array, 0, -1));
}

TEST(BinarySearch, single) {
    int array[] = {0};
    ASSERT_GT(0, binarysearch(array, 1, 1));
    ASSERT_GT(0, binarysearch(array, 1, -1));
    ASSERT_EQ(0, binarysearch(array, 1, 0));
}

TEST(BinarySearch, two) {
    int array[] = {0, 1};
    ASSERT_GT(0, binarysearch(array, 2, -1));
    ASSERT_GT(0, binarysearch(array, 2, 3));
    ASSERT_EQ(0, binarysearch(array, 2, 0));
    ASSERT_EQ(1, binarysearch(array, 2, 1));
}

TEST(BinarySearch, three) {
    int array[] = {-3, 1, 4};
    ASSERT_GT(0, binarysearch(array, 3, -4));
    ASSERT_GT(0, binarysearch(array, 3, -2));
    ASSERT_GT(0, binarysearch(array, 3, 3));
    ASSERT_GT(0, binarysearch(array, 3, 5));
    ASSERT_EQ(0, binarysearch(array, 3, -3));
    ASSERT_EQ(1, binarysearch(array, 3, 1));
    ASSERT_EQ(2, binarysearch(array, 3, 4));
}

TEST(BinarySearch, four) {
    int array[] = {-3, -2, 1, 4};
    ASSERT_GT(0, binarysearch(array, 4, -4));
    ASSERT_GT(0, binarysearch(array, 4, -1));
    ASSERT_GT(0, binarysearch(array, 4, 3));
    ASSERT_GT(0, binarysearch(array, 4, 5));
    ASSERT_EQ(0, binarysearch(array, 4, -3));
    ASSERT_EQ(1, binarysearch(array, 4, -2));
    ASSERT_EQ(2, binarysearch(array, 4, 1));
    ASSERT_EQ(3, binarysearch(array, 4, 4));
}
