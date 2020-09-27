-- -------------------------------------------------------------
-- TablePlus 3.9.1(342)
--
-- https://tableplus.com/
--
-- Database: SQLite Database-projekt.db
-- Generation Time: 2020-09-27 19:28:35.2330
-- -------------------------------------------------------------

DROP TABLE IF EXISTS "Users";
CREATE TABLE Users (UserID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, Username TEXT NOT NULL, Password TEXT NOT NULL, UNIQUE(UserID));

DROP TABLE IF EXISTS "Messages";
CREATE TABLE "Messages" (MessageID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, SenderID INTEGER NOT NULL, RecieverID INTEGER NOT NULL, Message TEXT, UNIQUE(MessageID), FOREIGN KEY(SenderID) REFERENCES Users(UserID), FOREIGN KEY(RecieverID) REFERENCES Users(UserID));

CREATE VIEW ReadableMessagesView 
AS 
SELECT
	messages.MessageID,
	senderUser.Username 'SenderName',
	recieverUser.Username 'RecieverName',
	messages.Message
FROM
	Messages messages
	LEFT JOIN Users senderUser ON messages.SenderID = senderUser.UserID
	LEFT JOIN Users recieverUser ON messages.RecieverID = recieverUser.UserID;