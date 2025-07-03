//! This `hub` crate is the
//! entry point of the Rust logic.

use rinf::debug_print;

mod signals;
mod tutorial_functions;

// Uncomment below to target the web.
// use tokio_with_wasm::alias as tokio;

rinf::write_interface!();

// You can go with any async library, not just `tokio`.
#[tokio::main(flavor = "current_thread")]
async fn main() {
    debug_print!("started");

    tokio::spawn(tutorial_functions::calculate_precious_data());
    tokio::spawn(tutorial_functions::stream_amazing_number());

    // Keep the main function running until Dart shutdown.
    rinf::dart_shutdown().await;
}
