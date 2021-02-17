typedef unsigned long uint64;
static void next();

void start() {
  const uint64 MPP_MASK = (3 << 11);
  const uint64 MPP_S    = (1 << 11);

  uint64 x;
  asm volatile("csrr %0, mstatus" : "=r" (x));
  x = (x & ~MPP_MASK) | MPP_S;
  asm volatile("csrw mstatus, %0" : : "r" (x));
  asm volatile("csrw mepc   , %0" : : "r" ((uint64)next));
  asm volatile("csrw satp   , %0" : : "r" (0));
  asm volatile("mret");
}

void next() {
  const int PGSIZE   = 0x1000;
  const uint64 PTE_V = (1 << 0);
  const uint64 PTE_R = (1 << 1);

  const uint64 A2    = 0x80800000;
  const uint64 A1    = 0x80400000;
  const uint64 A0    = 0x80200000;

  const uint64 va    = 0x30000;
  const uint64 pa    = 0x50000;
  const uint64 a     = va & ~0xFFF;

  uint64 cpuid;
  asm volatile("mv %0, tp" : "=r" (cpuid));

  if (cpuid == 0) {
    char   *mem_1byte;
    uint64 *mem;

    mem_1byte = (char *) A2;
    for (int i = 0; i < PGSIZE; i++) mem_1byte[i] = 0;
    mem  = (uint64 *) (A2 + ((a >> 30) & 0x1FF)*8);
    *mem = ((A1 >> 12) << 10) | PTE_V;

    mem_1byte = (char *) A1;
    for (int i = 0; i < PGSIZE; i++) mem_1byte[i] = 0;
    mem  = (uint64 *) (A1 + ((a >> 21) & 0x1FF)*8);
    *mem = ((A0 >> 12) << 10) | PTE_V;

    mem_1byte = (char *) A0;
    for (int i = 0; i < PGSIZE; i++) mem_1byte[i] = 0;
    mem  = (uint64 *) (A0 + ((a >> 12) & 0x1FF)*8);
    *mem = ((pa >> 12) << 10) | PTE_V | PTE_R;

    mem  = (uint64 *) (A0 + (((a+PGSIZE) >> 12) & 0x1FF)*8);
    *mem = (((pa+PGSIZE) >> 12) << 10) | PTE_V | PTE_R;

    uint64 satp = ((8L << 60) | (A2 >> 12));
    asm volatile("csrw satp, %0" : : "r" (satp));
    asm volatile("sfence.vma zero, zero");
  }
  while (1) asm volatile("wfi");
}
