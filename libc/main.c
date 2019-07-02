// void _start (void) {}
int main(int argc, char **argv) {}
unsigned int errno = 0;

__attribute__((noreturn)) void abort();

extern unsigned char __heap_base;
typedef __UINTPTR_TYPE__ uintptr_t;
uintptr_t bump_pointer = (uintptr_t) &__heap_base;

void *sbrk(unsigned int inc) {
	uintptr_t addr = bump_pointer;
	bump_pointer += inc;
	return (void *) addr;
}

float roundf(float x) { return (int) (x + .5); }

// FIXME: Needed only in hb-subset builds, to be replaced with something better later
// or, remove the use in hb-cff-interp-dict-common.hh
double pow(double x, double y) {
	double result = x;
	while (--y > 0) result *= x;
	return result;
}
