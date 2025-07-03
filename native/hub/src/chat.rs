use std::time::Duration;

use rinf::{DartSignal, RustSignal, SignalPiece, debug_print};
use serde::{Deserialize, Serialize};

#[derive(Serialize, RustSignal, Default)]
pub struct User {
    pub id: String,
    pub name: String,
    pub avatar: Option<String>,
}

impl SignalPiece for User {}

#[derive(Serialize, RustSignal, Default)]
pub struct ChatMessage {
    pub user: User,
    pub is_me: bool,
    pub content: String,
}

#[derive(Deserialize, DartSignal)]
pub struct MessageSent {
    pub content: String,
}

pub async fn send_handler() {
    let receiver = MessageSent::get_dart_signal_receiver();
    while let Some(signal_pack) = receiver.recv().await {
        let message_sent = signal_pack.message;
        ChatMessage {
            content: message_sent.content,
            user: User {
                id: "a".to_string(),
                name: "myself".to_string(),
                avatar: None,
            },
            is_me: true,
            ..Default::default()
        }
        .send_signal_to_dart();
    }
}

pub async fn messages_handler() {
    tokio::time::sleep(Duration::from_secs(1)).await;

    ChatMessage {
        user: User {
            id: "b".to_string(),
            name: "them".to_string(),
            avatar: None,
        },
        content: "hello".to_string(),
        ..Default::default()
    }
    .send_signal_to_dart();

    tokio::time::sleep(Duration::from_secs(2)).await;

    ChatMessage {
        user: User {
            id: "a".to_string(),
            name: "myself".to_string(),
            avatar: None,
        },
        content: "world".to_string(),
        is_me: true,
        ..Default::default()
    }
    .send_signal_to_dart();

    tokio::time::sleep(Duration::from_secs(2)).await;

    ChatMessage {
        user: User {
            id: "b".to_string(),
            name: "them".to_string(),
            avatar: None,
        },
        content: "nananã".to_string(),
        is_me: false,
        ..Default::default()
    }
    .send_signal_to_dart();
}
