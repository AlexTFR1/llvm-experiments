/*
 * The 'length' parameter is defined as 'int' and no 'unsigned' or, what is
 * better, 'size_t' because I don't want to put any headers into the example
 * for compiler and need to return something if there is no 'tosearch' in
 * the 'array' (if length had been 'unsigned', a valid index could have been
 * larger then the maximum int value and therefore 'int' would have been an
 * illegal return type for the function.)
 *
 * So, the function will not work for arrays larger then the max value of 'int'
 * on the platform.
 */
int binarysearch(int array[], int length, int tosearch) {
    int L = 0; // no problem for unsigned
    int R = length - 1; // for unsigned additional checks are required:
                        // length > 0, and when we do R = middle - 1, middle > 0.
    while (R >= L) {
        unsigned middle = (L + R) / 2;
        if (tosearch == array[middle]) {
            return middle;
        }
        else if (tosearch > array[middle]) {
            L = middle + 1;
        } else {
            R = middle - 1;
        }
    }
    return -1;
}
