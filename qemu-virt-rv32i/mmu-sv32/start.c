typedef unsigned int uint32;
static void next();

void start() {
  const uint32 MPP_MASK = (3 << 11);
  const uint32 MPP_S    = (1 << 11);

  uint32 x;
  asm volatile("csrr %0, mstatus" : "=r" (x));
  x = (x & ~MPP_MASK) | MPP_S;
  asm volatile("csrw mstatus, %0" : : "r" (x));
  asm volatile("csrw mepc   , %0" : : "r" ((uint32)next));
  asm volatile("csrw satp   , %0" : : "r" (0));
  asm volatile("mret");
}

void next() {
  const int PGSIZE   = 0x1000;
  const uint32 PTE_V = (1 << 0);
  const uint32 PTE_R = (1 << 1);

  const uint32 A1    = 0x80800000;
  const uint32 A0    = 0x80400000;

  const uint32 va    = 0x30000;
  const uint32 pa    = 0x50000;
  const uint32 a     = va & ~0xFFF;

  uint32 cpuid;
  asm volatile("mv %0, tp" : "=r" (cpuid));

  if (cpuid == 0) {
    char   *mem_1byte;
    uint32 *mem;

    mem_1byte = (char *) A1;
    for (int i = 0; i < PGSIZE; i++) mem_1byte[i] = 0;
    mem  = (uint32 *) (A1 + ((a >> 22) & 0x1FF)*4);
    *mem = ((A0 >> 12) << 10) | PTE_V;

    mem_1byte = (char *) A0;
    for (int i = 0; i < PGSIZE; i++) mem_1byte[i] = 0;
    mem  = (uint32 *) (A0 + ((a >> 12) & 0x1FF)*4);
    *mem = ((pa >> 12) << 10) | PTE_V | PTE_R;

    mem  = (uint32 *) (A0 + (((a+PGSIZE) >> 12) & 0x1FF)*4);
    *mem = (((pa+PGSIZE) >> 12) << 10) | PTE_V | PTE_R;

    uint32 satp = ((1 << 31) | (A1 >> 12));
    asm volatile("csrw satp, %0" : : "r" (satp));
    asm volatile("sfence.vma zero, zero");
  }
  while (1) asm volatile("wfi");
}
