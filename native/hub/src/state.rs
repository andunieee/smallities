use rinf::{DartSignal, RustSignal};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, RustSignal, DartSignal)]
pub struct Box {
    pub current_number: i32,
}

pub async fn state_handler() {
    let receiver = Box::get_dart_signal_receiver();
    while let Some(signal_pack) = receiver.recv().await {
        let new_state = signal_pack.message;
        Box {
            current_number: new_state.current_number * 2,
        }
        .send_signal_to_dart();
    }
}
