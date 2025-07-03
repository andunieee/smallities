//! This `hub` crate is the
//! entry point of the Rust logic.

use rinf::debug_print;

mod chat;

// Uncomment below to target the web.
// use tokio_with_wasm::alias as tokio;

rinf::write_interface!();

// You can go with any async library, not just `tokio`.
#[tokio::main(flavor = "current_thread")]
async fn main() {
    tokio::spawn(chat::send_handler());
    tokio::spawn(chat::messages_handler());

    // Keep the main function running until Dart shutdown.
    rinf::dart_shutdown().await;
}
