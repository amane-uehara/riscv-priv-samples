extern void _trap_vector(void);
void main(void);
extern void _timer_add(unsigned int t);

void main(void) {
  unsigned int x;

  // set trap vector
  x = (unsigned int) _trap_vector;
  asm volatile("csrw mtvec, %0" : : "r" (x));

  // disable all interrupt
  asm volatile("csrr %0, mstatus" : : "r" (x));
  x &= ~(1 << 3); // mstatus.MIE
  asm volatile("csrw mstatus, %0" : : "r" (x));
  x = 0;
  asm volatile("csrw mie, %0" : : "r" (x));

  // init timer
  _timer_add(10000);

  // enable timer interrupt
  asm volatile("csrr %0, mstatus" : : "r" (x));
  x |= 1 << 3; // mstatus.MIE
  asm volatile("csrw mstatus, %0" : : "r" (x));
  x = 1 << 7;  // mie.MTIE
  asm volatile("csrw mie, %0" : : "r" (x));
}
