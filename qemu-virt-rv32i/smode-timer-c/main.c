void _trap_vector(void);
void main(void);
void smode_entry(void);
extern void _timer_add(unsigned int t);

void main(void) {
  unsigned int x;

  // disable all interrupt
  asm volatile("csrr %0, mstatus" : : "r" (x));
  x &= ~(1 << 3); // mstatus.MIE
  asm volatile("csrw mstatus, %0" : : "r" (x));
  x = 0;
  asm volatile("csrw mie, %0" : : "r" (x));

  // timer interrupt delegation
  x = 0xffff;
  asm volatile("csrw mideleg, %0" : : "r" (x));
  asm volatile("csrw medeleg, %0" : : "r" (x));

  // goto supervisor mode
  asm volatile("csrr %0, mstatus" : : "r" (x));
  x &= ~(3 << 11);
  x |= (1 << 11);
  asm volatile("csrw mstatus, %0" : : "r" (x));

  x = (unsigned int) smode_entry;
  asm volatile("csrw mepc, %0" : : "r" (x));

  asm volatile("mret");
}

void smode_entry(void) {
  unsigned int x;

  // set trap vector
  x = (unsigned int) _trap_vector;
  asm volatile("csrw stvec, %0" : : "r" (x));

  // init timer
  _timer_add(10000);

  // enable timer interrupt
  asm volatile("csrr %0, sstatus" : : "r" (x));
  x |= 1 << 1; // mstatus.SIE
  asm volatile("csrw sstatus, %0" : : "r" (x));
  x = 1 << 5;  // sie.STIE
  asm volatile("csrw sie, %0" : : "r" (x));
}
