fn main() {
    let a = 1;
    let b = 2;

    draw_line(a as f32, b as f32, 200., 200.);
}

pub fn draw_line(x1: f32, y1: f32, x2: f32, y2: f32) {
    unsafe {
        draw_line_unsafe(x1, y1, x2, y2);
    }
}

extern "C" {
    pub fn debug(text: char);
    pub fn draw_line_unsafe(x1: f32, y1: f32, x2: f32, y2: f32);
}
