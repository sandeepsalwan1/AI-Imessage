create database ai_imessage;
USE ai_imessage;

-- User profile table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table for storing conversations (group chats or 1-on-1 chats). Implementing both
CREATE TABLE Conversations (
    conversation_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Join table mapping users to conversations
CREATE TABLE ConversationParticipants (
    conversation_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (conversation_id, user_id),
    FOREIGN KEY (conversation_id) REFERENCES Conversations(conversation_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Storing messages table
CREATE TABLE Messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    conversation_id INT NOT NULL,
    sender_id INT NOT NULL,
    content TEXT NOT NULL,
    sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES Conversations(conversation_id),
    FOREIGN KEY (sender_id) REFERENCES Users(user_id)
);

-- Table for storing AI NLP.
CREATE TABLE SentimentAnalysis (
    analysis_id INT PRIMARY KEY AUTO_INCREMENT,
    message_id INT NOT NULL,
    sentiment_score DECIMAL(3,2) NOT NULL,  -- e.g., score between -1.00 and 1.00
    sentiment_label VARCHAR(20) NOT NULL,    -- e.g., 'positive', 'negative', 'neutral'
    analyzed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (message_id) REFERENCES Messages(message_id)
);
