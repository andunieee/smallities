//! This `hub` crate is the
//! entry point of the Rust logic.

use rinf::debug_print;

mod state;

// Uncomment below to target the web.
// use tokio_with_wasm::alias as tokio;

rinf::write_interface!();

// You can go with any async library, not just `tokio`.
#[tokio::main(flavor = "current_thread")]
async fn main() {
    tokio::spawn(state::state_handler());

    // Keep the main function running until Dart shutdown.
    rinf::dart_shutdown().await;
}
