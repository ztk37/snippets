pub const FLAG_BASE: u8 = 0b00000000;

pub const FLAG_A: u8 = 0b00000001;
pub const FLAG_B: u8 = 0b00000010;
pub const FLAG_C: u8 = 0b00000100;
pub const FLAG_D: u8 = 0b00001000;
pub const FLAG_E: u8 = 0b00010000;
pub const FLAG_F: u8 = 0b00100000;
pub const FLAG_G: u8 = 0b01000000;
pub const FLAG_H: u8 = 0b10000000;

fn main() {
  println!("{:#010b}", FLAG_BASE | FLAG_D | FLAG_H);
  
  println!("{:#010b}", 1 >> 0);
  println!("{:#010b}", 2 >> 0);
  println!("{:#010b}", 4 >> 0);
  println!("{:#010b}", 8 >> 0);
  println!("{:#010b}", 16 >> 0);
  println!("{:#010b}", 32 >> 0);
  println!("{:#010b}", 64 >> 0);
  println!("{:#010b}", 128 >> 0);
}
