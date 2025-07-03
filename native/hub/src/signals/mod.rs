use rinf::{DartSignal, RustSignal};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, RustSignal, DartSignal)]
pub struct Box {
    pub current_number: i32,
}
