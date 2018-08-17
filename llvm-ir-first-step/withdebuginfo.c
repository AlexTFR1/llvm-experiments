int function1(int a, double b);
int function2(int a, double b);

int function1(int a, double b) {
   return function2(10, 12.0);
}

int function2(int a, double b) {
    return a + function1(a, b);
}

int main() {
    double i = 10.0 * (double) 12;
    return function2(i, 12.0);
}