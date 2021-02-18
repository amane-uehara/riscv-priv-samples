extern int  _load_irq(void);
extern int  _uart_receive(void);
extern void _uart_send(int ch);
extern void _save_irq(int irq);

void trap_handler(int scause) {
  if (scause == 0x80000009) {
    int irq = _load_irq();
    if (irq == 10) {
      int ch = _uart_receive();
      _uart_send(ch);
    }
    _save_irq(irq);
  }
}
