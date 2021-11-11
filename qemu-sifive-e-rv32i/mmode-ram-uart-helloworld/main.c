extern void _uart_send(int ch);

int main(void) {
  _uart_send((int) 'h');
  _uart_send((int) 'e');
  _uart_send((int) 'l');
  _uart_send((int) 'l');
  _uart_send((int) 'o');
  _uart_send((int) ' ');
  _uart_send((int) 'w');
  _uart_send((int) 'o');
  _uart_send((int) 'r');
  _uart_send((int) 'l');
  _uart_send((int) 'd');
  _uart_send((int) '\n');
  return 0;
}
